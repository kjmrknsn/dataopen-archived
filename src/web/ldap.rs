use ldap3::{LdapConn, Scope};
use std::error::Error;
use super::config::LDAP;

pub fn auth(conf: &LDAP, uid: &str, password: &str) -> Result<(), Box<Error>> {
    let ldap = LdapConn::new(conf.url.as_str())?;

    let user_dn = conf.user_dn.replace("{}", uid);

    ldap.simple_bind(user_dn.as_str(), password)?.success()?;

    let (res, _) = ldap.search(conf.group_dn.as_str(), Scope::Subtree, format!("member={}", user_dn).as_str(), Vec::<&'static str>::new())?.success()?;

    println!("res: {:?}", res);

    Ok(())
}
