use iron::prelude::*;
use iron::status;
use persistent;
use redis::Commands;
use serde_json;
use std::io::prelude::*;
use super::super::config::Config;
use super::super::ldap;
use super::super::redis_client::RedisClient;
use super::super::session::Session;
use super::super::sign_in_form::SignInForm;
use super::super::string_error::StringError;
use uuid::Uuid;

pub fn sign_in(req: &mut Request) -> IronResult<Response> {
    let mut body = String::new();

    if let Err(err) = req.body.read_to_string(&mut body) {
        return Err(IronError::new(StringError(format!("{}", err)), status::BadRequest))
    }

    let sign_in_form: SignInForm = match serde_json::from_str(&body) {
        Ok(sign_in_form) => sign_in_form,
        Err(err) => return Err(IronError::new(StringError(format!("{}", err)), status::BadRequest))
    };

    let arc = req.get::<persistent::Read<Config>>().unwrap();
    let conf = arc.as_ref();

    if let Err(err) = ldap::auth(&conf.ldap, &sign_in_form.user_id, &sign_in_form.password) {
        return Err(IronError::new(StringError(format!("{}", err)), status::BadRequest))
    }

    let sid = Uuid::new_v4().to_string();

    let arc = req.get::<persistent::Read<RedisClient>>().unwrap();
    let redis_client = arc.as_ref();

    match redis_client.session.set_ex(&sid, &sign_in_form.user_id, conf.session.ttl_sec) {
        Ok(true) => (),
        Ok(false) => return Err(IronError::new(
            StringError(String::from("Failed to set sid to Redis.")),
            status::InternalServerError)
        ),
        Err(err) => return Err(IronError::new(
            StringError(format!("{}", err)),
            status::InternalServerError)
        )
    }

    let session = Session::new(sign_in_form.user_id.clone());

    let session = match serde_json::to_string(&session) {
        Ok(session) => session,
        Err(err) => return Err(IronError::new(
            StringError(format!("{}", err)),
            status::InternalServerError)
        ),
    };

    Ok(Response::with((
        status::Ok,
        super::content_type(),
        super::set_cookie(Some(&sid), Some(conf.session.ttl_sec)),
        session
    )))
}
