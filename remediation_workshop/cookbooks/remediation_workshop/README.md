# remediation_workshop
This one is diffcult to demo as it has been implemented on our on premise Chef and Automate servers.

### Added folders
* inspec
```
    +---inspec
    |   |   deloitte-windows-baseline.zip
    |   |
    |   \---deloitte-windows-baseline
    |       |   inspec.yml
    |       |   README.md
    |       |
    |       +---controls
    |       |       windows_hibernate.rb
    |       |       windows_http.rb
    |       |       windows_security.rb
    |       |       windows_snmp.rb
    |       |       windows_timezone.rb
    |       |       windows_winrm.rb
    |       |
    |       \---libraries
    |               .gitkeep
```
* recipe - http.rb
```
+---recipes
|       default.rb
|       http.rb
```

### Process
* We have on prem Chef and Automate Server, and they are configured to work together
* when a new node is bootstrapped the 'audit' role is applied which contains the deloitte-windows-baseline compliance profile
* the controls listed above are reported as not complaint if the settings are off
* several cookbooks are in development, one of which is gts_cto_gpo which manages global windows settings
* the http.rb recipe ensures that the http settings defined in compliance control are applied to every node.
** Note: the recipe make use of powershell to set the registry properties. I encountered some limitations in the registry_key resource. It checks for registry existence and creates it, if missing, and sets any properties. However if the key exists, the resource doesn't not update incorrect properties.