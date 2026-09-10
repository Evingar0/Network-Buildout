Enable-PSRemoting -Force

Enter-PSSession -ComputerName DC1 -Credential $Cred   

Import-Module ActiveDirectory


Import-CSV "C:\Data\Users2.csv" | ForEach-Object {

    # Convert password to secure string
    $securePass = ConvertTo-SecureString $_.Password -AsPlainText -Force

    # Create the user
    New-ADUser `
        -Name "$($_.FirstName) $($_.LastName)" `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -SamAccountName $_.SamAccountName `
        -UserPrincipalName "$($_.SamAccountName)@yourdomain.local" `
        -Path $_.OU `
        -AccountPassword $securePass `
        -Enabled $true

    # Force password change at next logon
    Set-ADUser $_.SamAccountName -ChangePasswordAtLogon $true

    if ($_.Groups) {
        $_.Groups.Split(";") | ForEach-Object {
            Add-ADGroupMember -Identity $_ -Members $($_.SamAccountName)
        }
    }
}
