#
# Cookbook Name:: .
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# variables
iisaccount = Chef::EncryptedDataBagItem.load("passwords", "iisaccount")
user = iisaccount["user"]
pass = iisaccount["pass"]

# Install SQL Server.
#include_recipe 'sql_server::server'

# Create a path to the SQL file in the Chef cache.
create_database_script_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'create-database.sql'))

# Copy the SQL file from the cookbook to the Chef cache.
cookbook_file create_database_script_path do
  source 'create-database.sql'
end

# Get the full path to the SQLPS module.
sqlps_module_path = ::File.join(ENV['programfiles(x86)'], 'Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS')

# Run the SQL file only if the 'learnchef' database has not yet been created.
powershell_script 'Initialize database' do
  code <<-EOH
	$sqlpsPath = (resolve-path "C:\\Program Files*\\Microsoft SQL Server\\*\\Tools\\PowerShell\\Modules\\sqlps").path
	Import-Module $sqlpsPath -DisableNameChecking
    Invoke-Sqlcmd -InputFile #{create_database_script_path}
  EOH
  guard_interpreter :powershell_script
  only_if <<-EOH
	$sqlpsPath = (resolve-path "C:\\Program Files*\\Microsoft SQL Server\\*\\Tools\\PowerShell\\Modules\\sqlps").path
	Import-Module $sqlpsPath -DisableNameChecking
    (Invoke-Sqlcmd -Query "SELECT COUNT(*) AS Count FROM sys.databases WHERE name = 'learnchef'").Count -eq 0
  EOH
end

template win_friendly_path(File.join(Chef::Config[:file_cache_path], 'grant-access.sql')) do
  source 'grant-access.sql.erb'
  variables(
    :user => "#{user}"
  )
end

# Create a path to the SQL file in the Chef cache.
grant_access_script_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'grant-access.sql'))

## Copy the SQL file from the cookbook to the Chef cache.
#cookbook_file grant_access_script_path do
#  source 'grant-access.sql'
#end

# Run the SQL file only if IIS APPPOOL\Products does not have access.
powershell_script 'Grant SQL access to IIS' do
  code <<-EOH
	$sqlpsPath = (resolve-path "C:\\Program Files*\\Microsoft SQL Server\\*\\Tools\\PowerShell\\Modules\\sqlps").path
	Import-Module $sqlpsPath -DisableNameChecking
    Invoke-Sqlcmd -InputFile #{grant_access_script_path}
  EOH
  guard_interpreter :powershell_script
  not_if <<-EOH
    $sqlpsPath = (resolve-path "C:\\Program Files*\\Microsoft SQL Server\\*\\Tools\\PowerShell\\Modules\\sqlps").path
	Import-Module $sqlpsPath -DisableNameChecking
    $sp = Invoke-Sqlcmd -Database learnchef -Query "EXEC sp_helprotect @username = '#{user}', @name = 'customers'"
    ($sp.ProtectType.Trim() -eq 'Grant') -and ($sp.Action.Trim() -eq 'Select')
  EOH
end
