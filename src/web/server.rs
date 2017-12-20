use iron::Timeouts;
use iron::prelude::*;
use super::args::Args;
use super::chain;
use super::config::Config;
use super::super::log;

pub fn run() {
    let args = Args::new();

    if args.print_version {
        println!("{}", appname_version());
        return;
    }

    let conf = Config::from(&args.conf_path);

    log::info(&appname_version());
    log::info(&format!(
        "Listening on {}. (Number of threads: {})",
        conf.http.addr,
        conf.http.num_threads)
    );

    let iron = Iron {
        handler: chain::new(),
        timeouts: Timeouts::default(),
        threads: conf.http.num_threads,
    };

    iron.http(&conf.http.addr).unwrap();
}

fn appname_version() -> String {
    format!("Data Open Web {}", env!("CARGO_PKG_VERSION"))
}
