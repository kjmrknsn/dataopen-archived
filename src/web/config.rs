use iron::typemap::Key;
use std::fs::File;
use std::io::prelude::*;
use toml;

/// Configuration for Livy Manager
#[derive(Clone, Debug, Deserialize)]
pub struct Config {
    pub ldap: LDAP,
    pub http: HTTP,
    pub redis: Redis,
    pub session: Session,
}

impl Key for Config {
    type Value = Self;
}

impl Config {
    pub fn from(path: &str) -> Config {
        let mut f = File::open(path).unwrap();
        let mut contents = String::new();
        f.read_to_string(&mut contents).unwrap();
        toml::from_str(contents.as_str()).unwrap()
    }
}

/// Configuration for LDAP authentication
#[derive(Clone, Debug, Deserialize)]
pub struct LDAP {
    pub url: String,
    pub user_dn: String,
}

/// Configuration for HTTP
#[derive(Clone, Debug, Deserialize)]
pub struct HTTP {
    pub addr: String,
    pub num_threads: usize,
}

/// Configuration for Redis
#[derive(Clone, Debug, Deserialize)]
pub struct Redis {
    pub session_db_url: String,
}

/// Configuration for session
#[derive(Clone, Debug, Deserialize)]
pub struct Session {
    pub ttl_sec: usize,
}
