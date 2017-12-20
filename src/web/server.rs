use iron::prelude::*;
use super::router;

pub fn run() {
    Iron::new(router::new()).http("localhost:3000").unwrap();
}
