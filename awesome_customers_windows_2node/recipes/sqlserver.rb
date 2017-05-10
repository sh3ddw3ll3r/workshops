#
# Cookbook Name:: awesome_customers_windows
# Recipe:: sqlserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Cookbook Name:: SQL_Server_2012_STD_x64
# Recipe:: default
#
# Copyright (c) 2014 Ryan Irujo, All Rights Reserved.

# Declaring Variables
iso_filename	  = "en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso"
iso_url           = "http://usdttdevbe072.us.dttplatform.dev/chef/#{iso_filename}"
iso_path          = "C:\\Temp\\#{iso_filename}"
sql_svc_act       = "us\\dtt_sc_ehunsberger"
#sql_svc_pass      = ""
sql_sysadmins     = "BUILTIN\\ADMINISTRATORS"
sql_agent_svc_act = "NT AUTHORITY\\Network Service"

# Creating a Temporary Directory to work from.
directory "C:\\Temp\\" do
	rights :full_control, "#{sql_svc_act}"
	inherits true
	action :create
end

# Download the SQL Server 2012 Standard ISO from a Web Share.

powershell_script 'Download SQL Server 2012 STD ISO' do
	code <<-EOH
		$Client = New-Object System.Net.WebClient
		$Client.DownloadFile("#{iso_url}", "#{iso_path}")
		EOH
	guard_interpreter :powershell_script
	# not_if { File.exists?(iso_path)}
	not_if '((gwmi -class win32_service | Where-Object {$_.Name -eq "MSSQLSERVER"}).Name -eq "MSSQLSERVER")'
end

# Mounting the SQL Server 2012 SP1 Standard ISO.
powershell_script 'Mount SQL Server 2012 STD ISO' do
	code  <<-EOH
		Mount-DiskImage -ImagePath "#{iso_path}"
        if ($? -eq $True)
		{
			echo "SQL Server 2012 STD ISO was mounted Successfully." > C:\\temp\\SQL_Server_2012_STD_ISO_Mounted_Successfully.txt
			exit 0;
		}
		
		if ($? -eq $False)
        {
			echo "The SQL Server 2012 STD ISO Failed was unable to be mounted." > C:\\temp\\SQL_Server_2012_STD_ISO_Mount_Failed.txt
			exit 2;
        }
		EOH
	guard_interpreter :powershell_script
	only_if { File.exists?(iso_path)}
end

# Installing SQL Server 2012 Standard.
powershell_script 'Install SQL Server 2012 STD' do
	code <<-EOH
		$SQL_Server_ISO_Drive_Letter = (get-volume -DiskImage (get-diskimage "#{iso_path}")).DriveLetter
		write-host "ISO MOUNTED TO $SQL_Server_ISO_Drive_Letter"
		cd "${SQL_Server_ISO_Drive_Letter}:\\"
		$Install_SQL = ./Setup.exe /q /ACTION=Install /FEATURES=SQL,TOOLS /UpdateEnabled=False /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="#{sql_sysadmins}" /AGTSVCACCOUNT="#{sql_agent_svc_act}" /IACCEPTSQLSERVERLICENSETERMS	
		$Install_SQL > C:\\temp\\SQL_Server_2012_STD_Install_Results.txt
		EOH
	guard_interpreter :powershell_script
	not_if '((gwmi -class win32_service | Where-Object {$_.Name -eq "MSSQLSERVER"}).Name -eq "MSSQLSERVER")'
end

# Dismounting the SQL Server 2012 STD ISO.
powershell_script 'Delete SQL Server 2012 STD ISO' do
	code <<-EOH
		Dismount-DiskImage -ImagePath "#{iso_path}"
		EOH
	guard_interpreter :powershell_script
	only_if { File.exists?(iso_path)}
end


# Removing the SQL Server 2012 STD ISO from the Temp Directory.
powershell_script 'Delete SQL Server 2012 STD ISO' do
	code <<-EOH
		[System.IO.File]::Delete("#{iso_path}")
		EOH
	guard_interpreter :powershell_script
	only_if { File.exists?(iso_path)}
end

# Enable TCP/IP for installed SQL Server 2012 STD
powershell_script 'Enable TCPIP' do
	code <<-EOH
		$sqlpsPath = (resolve-path "C:\\Program Files*\\Microsoft SQL Server\\*\\Tools\\PowerShell\\Modules\\sqlps").path
		Import-Module $sqlpsPath -DisableNameChecking
		$smo = 'Microsoft.SqlServer.Management.Smo.'
		$wmi = new-object ($smo + 'Wmi.ManagedComputer').
		$uri = "ManagedComputer[@Name='{0}']/ ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']" -f $env:computername
		$Tcp = $wmi.GetSmoObject($uri)  
		$Tcp.IsEnabled = $true  
		$Tcp.Alter()  
		get-service 'MSSQLSERVER' | stop-service
		get-service 'MSSQLSERVER' | start-service
	EOH
	guard_interpreter :powershell_script
	not_if '(Test-NetConnection $env:computername -Port 1433).TcpTestSucceeded'
end

#Stop SQL to pickup the TCP/IP change
#windows_service 'MSSQLSERVER' do
#  action :stop
#end

#Start SQL to pickup the TCP/IP change
#windows_service 'MSSQLSERVER' do
#  action :start
#end