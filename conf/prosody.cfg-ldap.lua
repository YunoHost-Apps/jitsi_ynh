    -- enabled = false -- Remove this line to enable this host
    authentication = "ldap"
    ldap_server = "localhost"
    ldap_filter = "(uid=$user)"
    ldap_scope = "subtree"
    ldap_base = "ou=users,dc=yunohost,dc=org"
    ldap_mode = "bind"
