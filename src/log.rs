use chrono::prelude::*;

const ACCESS: &str = "access";
const INFO: &str = "info";
const WARN: &str = "warn";
const ERROR: &str = "error";

pub fn access(msg: &str) {
    print(ACCESS, msg);
}

pub fn info(msg: &str) {
    print(INFO, msg);
}

pub fn warn(msg: &str) {
    print(WARN, msg);
}

pub fn error(msg: &str) {
    print(ERROR, msg);
}

fn print(kind: &str, msg: &str) {
    eprintln!("{} {} {}", Local::now(), kind, msg);
}
