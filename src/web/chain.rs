use iron::prelude::*;
use persistent::Read;
use super::access_logger::AccessLogger;
use super::config::Config;
use super::redis_client::RedisClient;
use super::router;

pub fn new(conf: &Config, redis_client: RedisClient) -> Chain {
    let mut chain = Chain::new(router::new());

    chain.link(Read::<Config>::both(conf.clone()));
    chain.link(Read::<RedisClient>::both(redis_client));

    chain.around(AccessLogger);

    chain
}
