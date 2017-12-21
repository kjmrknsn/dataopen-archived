use iron::typemap::Key;
use redis::Client;
use super::config::Redis;

pub struct RedisClient {
    pub session: Client,
}

impl Key for RedisClient {
    type Value = Self;
}

impl RedisClient {
    pub fn new(conf: &Redis) -> Self {
        let session = Client::open(conf.session_db_url.as_str()).unwrap();

        RedisClient {
            session,
        }
    }
}
