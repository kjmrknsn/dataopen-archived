use ldap3::LdapConn;
use std::error::Error;
use super::config::LDAP;

pub fn auth(conf: &LDAP, uid: &str, password: &str) -> Result<(), Box<Error>> {
    let ldap = LdapConn::new(conf.url.as_str())?;

    let user_dn = conf.user_dn.replace("{}", uid);

    ldap.simple_bind(user_dn.as_str(), password)?.success()?;

    Ok(())
}
