use iron::prelude::*;
use iron::status;
use router::Router;

pub fn run() {
    Iron::new(router()).http("localhost:3000").unwrap();
}

fn router() -> Router {
    let mut router = Router::new();

    router.get("/", hello_world, "index");

    router
}

fn hello_world(_: &mut Request) -> IronResult<Response> {
    Ok(Response::with((status::Ok, "Hello, Data Open Web.")))
}
