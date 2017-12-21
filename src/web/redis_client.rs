use iron::typemap::Key;
use redis::Client;
use super::config::Redis;

pub struct RedisClient {
    pub client: Client,
}

impl Key for RedisClient {
    type Value = Self;
}

impl RedisClient {
    pub fn new(conf: &Redis) -> Self {
        let client = Client::open(conf.url.as_str()).unwrap();

        RedisClient {
            client,
        }
    }
}
