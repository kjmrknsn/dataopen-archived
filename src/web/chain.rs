use iron::prelude::*;
use super::router;

pub fn new() -> Chain {
    let mut chain = Chain::new(router::new());

    chain
}
