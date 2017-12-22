use router::Router;
use super::handler;

pub fn new() -> Router {
    let mut router = Router::new();

    router.get("/web/session", handler::session::get, "get_session");
    router.post("/web/sign_in", handler::sign_in::sign_in, "sign_in");

    router
}
