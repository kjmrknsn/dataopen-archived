use iron::prelude::*;
use super::args::Args;
use super::chain;
use super::config::Config;

pub fn run() {
    let args = Args::new();

    let conf = Config::from(&args.conf_path);

    println!("{:?}, {:?}", args, conf);

    Iron::new(chain::new()).http("localhost:3000").unwrap();
}
