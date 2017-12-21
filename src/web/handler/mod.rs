use chrono::Duration;
use chrono::prelude::*;
use iron::headers::{ContentType, SetCookie};
use iron::mime;
use iron::mime::{Attr, Mime, TopLevel, SubLevel};
use iron::modifiers::Header;

pub mod sign_in;

const SID_COOKIE_NAME: &'static str = "_dataopen_sid";

pub fn content_type() -> Header<ContentType> {
    Header(ContentType(Mime(TopLevel::Application, SubLevel::Json, vec![(Attr::Charset, mime::Value::Utf8)])))
}

pub fn set_cookie(sid: Option<&str>, ttl_sec: Option<usize>) -> Header<SetCookie> {
    match (sid, ttl_sec) {
        (Some(sid), Some(ttl_sec)) => {
            Header(SetCookie(vec![format!(
                "{}={}; expires={}; path=/",
                SID_COOKIE_NAME,
                sid,
                expires(Duration::seconds(ttl_sec as i64))
            )]))
        },
        _ => {
            Header(SetCookie(vec![format!(
                "{}=; expires={}; path=/",
                SID_COOKIE_NAME,
                expires(Duration::seconds(-1))
            )]))
        },
    }
}

fn expires(offset: Duration) -> String {
    let dt = Utc::now() + offset;
    dt.format("%a %d %b %Y %H:%M:%S GMT").to_string()
}
