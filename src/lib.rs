//! # Data Open
//! Collaborative Data Analysis Platform

extern crate argparse;
extern crate chrono;
extern crate iron;
extern crate ldap3;
extern crate persistent;
extern crate router;
extern crate serde;
#[macro_use]
extern crate serde_derive;
extern crate serde_json;
extern crate toml;

/// Utilities for logging
pub mod log;
/// Modules for Data Open Web
pub mod web;
