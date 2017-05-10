# awesome\_customers\_windows
This cookbook is driven by roles defined within the Chef Server.

## Execution
1. hosts.json is configured with the server names and roles 
2. configureMultipleNodes_Workflow.ps1 is executed from a ChefDK PowerShell prompt

## Roles
* sqlserver - 
```
"run_list": [
		"recipe[awesome_customers_windows_2node::sqlserver]",
		"recipe[awesome_customers_windows_2node::database]"
  ]
  ```
* webserver - 
```
"run_list": [
	"recipe[awesome_customers_windows_2node::lcm]",
	"recipe[awesome_customers_windows_2node::web]"
]
```

## Recipes
* lcm - enable DSC local configuration manager on the target server, in ApplyOnly mode
* web
  * Installs IIS,  and ASP .NET features
  * Removes default website
  * creates application folders under c:\inetpub
  * Deploys application from [here](http://repo-server/chef/Customers.zip)
  * Creates Product AppPool, and sets user identity
  * Give IIS_USERS Rights to site folder
  * Creates Customers website and configures web.config with database connection information
* sqlserver
  * Download SQL Server from [here](http://repo-server/chef/en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso)
  * Install SQL Server
  * Enable TCP/IP in SQL Config
* database
  * Create learnchef database
  * Give IIS Server account access to learnchef database

## Databag
* Utilizes a databag to hold the IIS service account password.

## Templates
* grant-access.sql
* web.config

## Files
* create-database.sql