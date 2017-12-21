use iron::prelude::*;
use iron::status;
use persistent;
use serde_json;
use std::io::prelude::*;
use super::super::config::Config;
use super::super::ldap;
use super::super::string_error::StringError;
use super::super::sign_in_form::SignInForm;

pub fn h(req: &mut Request) -> IronResult<Response> {
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

    Ok(Response::with((status::Ok, super::content_type(), "{}")))
}
