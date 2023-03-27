# Get information for every Computers/Servers in the entire Domain #
#                 by Veselin Petkov                                #
####################################################################
Get-Date

$Today = Get-Date -Format "MMddyyyy"

$DataPath = "C:\temp\DomainADServerComputerStats_$Today.csv"

$Results = @()

Measure-Command {

    $ADC = Get-ADcomputer -Filter * -Properties *


    Write-Host "Total machines found" $adc.count 

    foreach ($Machine in $ADC) {

        $Properties = @{
            Name              = $Machine.Name
            DistinguishedName = $Machine.DistinguishedName
            Enabled           = $Machine.Enabled
            IPv4Address       = $Machine.IPv4Address
            DNSHostName       = $Machine.DNSHostName
            SamAccountName    = $Machine.SamAccountName
            ObjectGUID        = $Machine.ObjectGUID
            SID               = $Machine.SID
            OSVersion         = $Machine.OperatingSystem
            OSBuild           = $Machine.OperatingSystemVersion
            LastLogonDate     = $Machine.LastLogonDate
            WhenCreated       = $Machine.whenCreated
        }  
    
        $Results += New-Object PSObject -Property $Properties
    
    }
    $Results | Select-Object Name, DistinguishedName, Enabled, IPv4Address, DNSHostName, SamAccountName, ObjectGUID, SID, OSVersion, OSBuild, LastLogonDate, WhenCreated | Export-csv -NoTypeInformation -Path $DataPath

   

}