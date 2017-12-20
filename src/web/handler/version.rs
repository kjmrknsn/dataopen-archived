use iron::prelude::*;
use iron::status;

pub fn h(_: &mut Request) -> IronResult<Response> {
    Ok(Response::with((
        status::Ok,
        super::content_type(),
        format!(r#"{{"version": "{}"}}"#, env!("CARGO_PKG_VERSION"))
    )))
}
