#
# Cookbook Name:: awesome_customers_windows
# Recipe:: web
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Enable the IIS role.
dsc_script 'Web-Server' do
  code <<-EOH
  WindowsFeature InstallWebServer
  {
    Name = "Web-Server"
    Ensure = "Present"
  }
  EOH
end

# Install ASP.NET 4.5.
dsc_script 'Web-Asp-Net45' do
  code <<-EOH
  WindowsFeature InstallDotNet45
  {
    Name = "Web-Asp-Net45"
    Ensure = "Present"
  }
  EOH
end

# Install the IIS Management Console.
dsc_script 'Web-Mgmt-Console' do
  code <<-EOH
  WindowsFeature InstallIISConsole
  {
    Name = "Web-Mgmt-Console"
    Ensure = "Present"
  }
  EOH
 end
 
# Remove the default web site.
include_recipe 'iis::remove_default_site'

# Define the local app and site locations.
app_directory = 'C:\inetpub\apps\Customers'
web_config = 'C:\inetpub\apps\Customers\web.config'
site_directory = 'C:\inetpub\sites\Customers'

iisaccount = Chef::EncryptedDataBagItem.load("passwords", "iisaccount")
user = iisaccount["user"]
pass = iisaccount["pass"]

# Download the built Customers application and unzip it to the app directory.
#windows_zipfile app_directory do
#  source 'http://usdttdevbe072.us.dttplatform.dev/chef/Customers.zip'
#  action :unzip
#  not_if { ::File.exists?(app_directory) }
#end
powershell_script 'Deploy website files' do
	code <<-EOH
		$zipfile = "C:\\temp\\Customers.zip"
		invoke-webrequest http://usdttdevbe072.us.dttplatform.dev/chef/Customers.zip -OutFile $zipfile
		Add-Type -AssemblyName System.IO.Compression.FileSystem
		[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "#{app_directory}")
		EOH
	guard_interpreter :powershell_script
	not_if { File.exists?(app_directory)}
end

# Create the Products app pool.
iis_pool 'Products' do
  runtime_version '4.0'
  action :add
end

# Set the identity on the Products app pool.
iis_pool 'Products' do
  pool_identity :SpecificUser
  pool_username "#{user}"
  pool_password "#{pass}"
  action :config
end

# Create the site directory and give IIS_IUSRS read rights.
directory site_directory do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end

# Create the Customers site.
iis_site 'Customers' do
  protocol :http
  port 80
  path site_directory
  application_pool 'Products'
  action [:add, :start]
end

# Create the Customers app.
iis_app 'Customers' do
  application_pool 'Products'
  path '/Products'
  physical_path app_directory
  action :add
end

template web_config do
  source 'web.config.erb'
end