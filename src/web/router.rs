use router::Router;
use super::handler;

pub fn new() -> Router {
    let mut router = Router::new();

    router.post("/web/sign_in", handler::sign_in::h, "sign_in");

    router
}
