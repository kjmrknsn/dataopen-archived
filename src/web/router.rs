use router::Router;
use super::handler;

pub fn new() -> Router {
    let mut router = Router::new();

    router.get("/api/version", handler::version::h, "version");

    router
}
