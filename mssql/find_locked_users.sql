SELECT ServerName = @@SERVERNAME
    , LoginName = sp.name
    , LockoutTime = LOGINPROPERTY(sp.name, 'LockoutTime')
    , IsLocked = LOGINPROPERTY(sp.name, 'IsLocked')
    , BadPasswordCount = LOGINPROPERTY(sp.name, 'BadPasswordCount')
    , DaysUntilExpiration = LOGINPROPERTY(sp.name, 'DaysUntilExpiration')
FROM master.sys.server_principals sp
WHERE (
       LOGINPROPERTY(sp.name, 'IsLocked') = 1
    OR LOGINPROPERTY(sp.name, 'BadPasswordCount') > 0
    OR LOGINPROPERTY(sp.name, 'DaysUntilExpiration') < 5
    )
    AND sp.type_desc = N'SQL_LOGIN'
ORDER BY sp.name;
