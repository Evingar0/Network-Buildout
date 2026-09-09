New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "198.168.1.2" -PrefixLength 26 -DefaultGateway "198.168.1.1"   

Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses @("198.168.1.2")   

Rename-Computer -NewName "DC1" -Restart -Force   

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools   

Import-Module ADDSDeployment

$DSRMPassword = ConvertTo-SecureString "D3F4ULTp@ssW0rd" -AsPlainText -Force

Install-ADDSForest -DomainName "PACHABEL.com" -SafeModeAdministratorPassword $DSRMPassword -InstallDNS -Force   


Import-Module ActiveDirectory

New-ADUser -Name "admin" -SamAccountName "admin" -UserPrincipalName "admin@pachabel.com" -AccountPassword (Read-Host -AsSecureString "Enter Password") -Enabled $true

Add-ADGroupMember -Identity "Domain Admins" -Members "admin"
