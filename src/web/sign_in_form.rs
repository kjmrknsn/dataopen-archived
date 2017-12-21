#[derive(Debug, Deserialize, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SignInForm {
    pub user_id: String,
    pub password: String,
}
