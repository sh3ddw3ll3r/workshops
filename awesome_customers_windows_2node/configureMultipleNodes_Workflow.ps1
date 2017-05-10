Param(
		[parameter()]
		[string]$UserName = $null,
		[parameter()]
		[string]$Password = $null
)

Workflow Configure-DotnetServers {
	Param(
		[parameter(Mandatory=$True)]
		$Cred,
		[parameter(Mandatory=$True)]
		$ServerList,
		[parameter()]
		[string]$ChefMSIUrl = "http://repo-server/chef/chef-client-latest.msi"
	)
	
	$username = $cred.UserName
	$password = $cred.GetNetworkCredential().password
	$dbserver = ($ServerList | where {$_.Role -eq "sqlserver"}).Name
	
	foreach -parallel ($serverObj in $ServerList) {
		#write-host "`n`nBootstrapping $($serverObj.Name)..."
$jsonAttrs = @"
{"dbserver": "$dbserver"}
"@
		#$daKnifeArgList = "bootstrap windows winrm $serverObj.Name --winrm-user $username --winrm-password $password --node-name $serverObj.Name --run-list `"role[$($serverObj.Name)]`" --winrm-transport plaintext --msi-url http://usdttdevbe072.us.dttplatform.dev/chef/chef-client-latest.msi -j $jsonAttrs"
		
		#$process = Start-process -FilePath "c:\apps\opscode\chefdk\bin\knife" -Argumentlist "$daKnifeArgList" -Wait -PassThru -NoNewWindow -RedirectStandardOutput "$PSScriptRoot\$($serverObj.Name)_bootstrap.log"
		$serverName = $serverObj.Name
		$serverRole = $serverObj.Role
		$currpath = $pwd.Path
		$knifeConfig = "${currpath}\.chef\knife.rb"
		$secretFile = "${currpath}\encrypted_data_bag_secret"
				
		# do some real work on the nodes
		knife node delete --yes $Servername --config $knifeConfig
		knife client delete --yes $Servername --config $knifeConfig
		knife bootstrap windows winrm $Servername --winrm-user $workflow:username --winrm-password $workflow:password --node-name $Servername --run-list role[$serverRole] --winrm-transport plaintext --msi-url $workflow:ChefMSIUrl --config $knifeConfig -j (convertto-json $jsonAttrs)
	}
}

##################
# Main
##################
if ( [string]::IsNullOrEmpty($UserName) -or [string]::IsNullOrEmpty($PassWord) ){
	$cred = get-credential
	if ($cred.UserName.indexof("@") -eq -1) {
		write-warning "Username must be in user@domain format"
		exit
	}
} else {
	if ($username.indexof("@") -eq -1) {
		write-warning "Username must be in user@domain format"
		exit
	}
	$secPassword = $password | ConvertTo-SecureString -asPlainText -Force
	$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username,$secPassword
}

$jsonConfigFileName = "hosts.json"
$fqJsonConfigFile = "$PSScriptRoot\$jsonConfigFileName"
$jsonConfigObject = (get-content $fqJsonConfigFile) -join "`n" | convertfrom-json

# copy the encryption key to the nodes
foreach ($serverObj in $jsonConfigObject) {
	$Session = New-PSSession -ComputerName $serverObj.Name -Credential $cred
	write-host "Copying encrypted_data_bag_secret to $($serverObj.Name)"
	invoke-command -Session $session -scriptblock {New-Item -ItemType File -Path "C:\chef\encrypted_data_bag_secret" -Force }
	copy-item "$PSScriptRoot\encrypted_data_bag_secret" -Destination "C:\chef\" -ToSession $session -Force
	$session | remove-PSSession
}

Configure-DotnetServers -Cred $cred -ServerList $jsonConfigObject
