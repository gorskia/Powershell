Import-Csv "C:\temp\test.csv" -Delimiter ';' |
 
ForEach-Object { 
New-ADUser `
-cn $_.cn `
-displayName $_.displayName `
-Surname $_.sn `
-distinguishedName $_.distinguishedName `
-sAMAccountName $_.sAMAccountName `
-UserPrincipalName ($_.sAMAccountName + '@' + $env:userdnsdomain) `
-AccountPassword (ConvertTo-SecureString "123user!!!!!" -AsPlainText -Force) `
-EmailAddress $_.mail`
-Enabled $true `
-ChangePasswordAtLogon $true
} 