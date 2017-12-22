use iron::prelude::*;
use iron::status;
use serde_json;
use super::super::session::SessionBeforeHandler;
use super::super::string_error::StringError;

pub fn get(req: &mut Request) -> IronResult<Response> {
    match req.extensions.get::<SessionBeforeHandler>() {
        Some(session) => {
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
                session
            )))
        },
        None => Err(IronError::new(
            StringError("Not signed in.".to_string()),
            status::NotFound
        )),
    }
}
