Get-Date

$Today = Get-Date -Format "MMddyyyy"

$DataPath = "C:\temp\ADCompStats_$Today.csv"

$Results = @()

$ADC = Get-ADcomputer -Filter "Name -like 'WS*'" -Properties *


Write-Host "Total machines found" $adc.count 

foreach ($Machine in $ADC) {
    Write-Host "Checking machine" $Machine.Name 

    
        $OSInfo = Get-WMIObject win32_operatingsystem -ComputerName $Machine.Name

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
$Results | Select-Object Name,IPv4Address,DNSHostName,OSVersion,LastBootUpTime | Export-csv -NoTypeInformation -Path $DataPath

Get-Date
