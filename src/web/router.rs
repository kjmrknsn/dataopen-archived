use iron::prelude::*;
use iron::status;
use router::Router;

pub fn new() -> Router {
    let mut router = Router::new();

    router.get("/a/b/c", hello_world, "index");

    router
}

fn hello_world(_: &mut Request) -> IronResult<Response> {
    Ok(Response::with((status::Ok, "Hello, Data Open Web.")))
}
