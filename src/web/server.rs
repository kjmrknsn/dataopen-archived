use iron::prelude::*;
use iron::status;

fn hello_world(_: &mut Request) -> IronResult<Response> {
    Ok(Response::with((status::Ok, "Hello, Data Open Web.")))
}

pub fn run() {
    println!("On 3000");
    Iron::new(hello_world).http("localhost:3000").unwrap();
}
