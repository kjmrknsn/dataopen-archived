#[derive(Debug, Deserialize, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Session {
    pub user_id: String,
}

impl Session {
    pub fn new(user_id: String) -> Self {
        Session {
            user_id,
        }
    }
}
