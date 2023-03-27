$Serverlist=
"WSV000009","WSV000023","WSV000014","WSV000012","WSV000025","WSV000019","WSV000005","WSV000002","WSV000006","WSV000007","WS0003189","WSV000010","WSV000008",`
"WSV000015","WS000937","WSV000003","WS000177","WS0003176","WSV000004","WS002012","WS0003194","WSV000029","WS002010","WSV000024","WS000939","WSV000028","WSV000021",`
"WS002015","WS002014","WS0003184","WS0003193","WS0003196","WS0003181","WS0003179","WS002011","WS002012","WS000246"

$Result = @()

foreach ($server in $Serverlist) {

    If (Test-Connection $server -count 1 -quiet) {

        $Mon = Invoke-Command -ComputerName $server -ScriptBlock { Get-PnpDevice -Status 'OK' -Class 'Monitor' -FriendlyName 'Generic Non-PnP Monitor'} 
        $User = Invoke-Command -ComputerName $Server -ScriptBlock {quser}
        $Properties = @{

            PSComputerName = $mon.PSComputerName 
            FriendlyName = $mon.FriendlyName -join (',')
            Status = $mon.Status
            User = $User
        }
        $Result +=New-Object psobject -Property $Properties

    }
}
$Result | Select-Object PSComputerName, User, FriendlyName, Status | Export-csv C:\Temp\Get_Monitor_Status.csv -NoTypeInformation

 














