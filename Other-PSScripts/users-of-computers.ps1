Get-Date

$Today = Get-Date -Format "MMddyyyy"

$DataPath = "C:\temp\ADStats_$Today.csv"

$Results = @()

$Machinelist = Get-Content -Path "D:\Users\mmoev\Desktop\AllAD-Computers.txt"


Write-Host "Total machines found" $adc.count 

foreach ($Machine in $Machinelist) {
    Write-Host "Checking machine" $Machine.Name 


        $BootInfo = Get-CimInstance -ClassName CIM_OperatingSystem -ComputerName $Machine.Name
    
        $Properties = @{
            Name = $Machine.Name
            DistinguishedName = $Machine.DistinguishedName
            Enabled = $Machine.Enabled
            IPv4Address = $Machine.IPv4Address
            DNSHostName = $Machine.DNSHostName
            SamAccountName = $Machine.SamAccountName
            ObjectGUID = $Machine.ObjectGUID
            SID = $Machine.SID
            OSVersion = $OSInfo.Caption
            OSBuild = $OSInfo.Version
            LastBootUpTime = $BootInfo.LastBootUpTime
            LastLogonDate = $Machine.LastLogonDate
            WhenCreated = $Machine.whenCreated
        }
    
        $Results += New-Object PSObject -Property $Properties
    
}
$Results | Select-Object Name,DistinguishedName,Enabled,IPv4Address,DNSHostName,SamAccountName,ObjectGUID,SID,OSVersion,OSBuild,LastBootUpTime,LastLogonDate,WhenCreated | Export-csv -NoTypeInformation -Path $DataPath

Get-Date






#$Users = Get-ADUser -Filter * -Properties *
#if (Test-Connection -ComputerName $ServerName -Count 1  -ErrorAction SilentlyContinue) 
#(Get-CimInstance -ClassName CIM_OperatingSystem).LastBootUpTime 
#(Get-WMIObject win32_operatingsystem) | Select-Object Caption, Version 
#$OSVer = (Get-WmiObject Win32_OperatingSystem -ComputerName $server | select-object Caption).Caption
#Select-Object DistinguishedName, DNSHostName, Enabled, lastLogonTimestamp, Name, ObjectClass, ObjectGUID, OperatingSystem, OperatingSystemVersion, SamAccountName, SID, UserPrincipalName, whenCreated 
#-Filter "Compressed = 'True'"
#Export-Csv C:\temp\ADStats.csv -NoTypeInformation -Append