# puppet-auditpol

puppet-auditpol is a Puppet type/provider to manage audit policies on Windows using auditpol.exe.

## example:

```puppet
auditpol { 'Account Lockout':
  success => 'enable',
  failure => 'disable',
}
```

results in

```
  PS C:\Windows\system32> auditpol /get /subcategory:"Account Lockout"
  System audit policy

  Category/Subcategory                      Setting
  Logon/Logoff
    Account Lockout                         Success
```
