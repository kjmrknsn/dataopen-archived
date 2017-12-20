use iron::prelude::*;
use super::chain;

pub fn run() {
    Iron::new(chain::new()).http("localhost:3000").unwrap();
}
