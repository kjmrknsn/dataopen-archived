use iron::prelude::*;
use persistent::Read;
use super::access_logger::AccessLogger;
use super::config::Config;
use super::router;

pub fn new(conf: &Config) -> Chain {
    let mut chain = Chain::new(router::new());

    chain.link(Read::<Config>::both(conf.clone()));
    chain.around(AccessLogger);

    chain
}
