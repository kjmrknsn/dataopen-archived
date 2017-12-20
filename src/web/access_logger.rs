use chrono::prelude::*;
use iron::{AroundMiddleware, Handler};
use iron::prelude::*;
use super::super::log;

pub struct AccessLogger;

impl AroundMiddleware for AccessLogger {
    fn around(self, handler: Box<Handler>) -> Box<Handler> {
        Box::new(AccessLoggerHandler::new(handler))
    }
}

struct AccessLoggerHandler<T: Handler> {
    handler: T,
}

impl<T: Handler> AccessLoggerHandler<T> {
    fn new(handler: T) -> Self {
        AccessLoggerHandler {
            handler,
        }
    }
}

impl<T: Handler> Handler for AccessLoggerHandler<T> {
    fn handle(&self, req: &mut Request) -> IronResult<Response> {
        let start = Local::now();
        let res = self.handler.handle(req);
        let end = Local::now();
        log::access(AccessLog::new(start, end, &res).to_string().as_str());
        res
    }
}

struct AccessLog<T>
    where T: TimeZone {
    start: DateTime<T>,
    end: DateTime<T>,
    error: String,
}

impl<T> AccessLog<T>
    where T: TimeZone {
    fn new(start: DateTime<T>, end: DateTime<T>, res: &IronResult<Response>) -> Self {
        match *res {
            Ok(ref res) => AccessLog {
                start,
                end,
                error: String::new(),
            },
            Err(ref err) => AccessLog {
                start,
                end,
                error: format!("{}", err),
            },
        }
    }
}

impl<T> ToString for AccessLog<T>
    where T: TimeZone {
    fn to_string(&self) -> String {
        format!("start:{:?}\tend:{:?}\telapsed:{:?}\terror:{}", self.start, self.end, elapsed_milli(&self.start, &self.end), self.error)
    }
}

fn elapsed_milli<T>(start: &DateTime<T>, end: &DateTime<T>) -> f64
    where T: TimeZone {
    match end.time().signed_duration_since(start.time()).num_nanoseconds() {
        Some(elapsed) => elapsed as f64 / 1000000.0,
        None => -1.0,
    }
}
