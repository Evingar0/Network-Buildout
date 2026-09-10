New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "198.168.1.3" -PrefixLength 26 -DefaultGateway "198.168.1.1"  
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses @("198.168.1.2")  

Add-Computer -DomainName "pachabel.com" -Credential (Get-Credential)
Restart-Computer

