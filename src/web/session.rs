use iron::prelude::*;
use iron::{BeforeMiddleware, typemap};
use iron::headers::Headers;
use persistent;
use redis::Commands;
use super::redis_client::RedisClient;

pub const SID_COOKIE_NAME: &'static str = "_dataopen_sid";

#[derive(Debug, Deserialize, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Session {
    pub user_id: String,
}

impl Session {
    pub fn new(user_id: String) -> Self {
        Session {
            user_id,
        }
    }
}

pub struct SessionBeforeHandler;

impl typemap::Key for SessionBeforeHandler {
    type Value = Session;
}

impl BeforeMiddleware for SessionBeforeHandler {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        if let Some(sid) = sid(&req.headers) {
            let arc = req.get::<persistent::Read<RedisClient>>().unwrap();
            let redis_client = arc.as_ref();

            if let Ok(Some(user_id)) = redis_client.session.get::<_, Option<String>>(&sid) {
                req.extensions.insert::<SessionBeforeHandler>(Session::new(user_id));
            }
        }

        Ok(())
    }
}

fn sid(headers: &Headers) -> Option<String> {
    for header in headers.iter() {
        if header.name() != "Cookie" {
            continue;
        }

        for kv in header.value_string().split(";") {
            let kv = kv.trim().split("=").collect::<Vec<&str>>();
            if kv.len() == 2 && kv[0] == SID_COOKIE_NAME {
                return Some(String::from(kv[1]))
            }
        }
    }

    None
}
