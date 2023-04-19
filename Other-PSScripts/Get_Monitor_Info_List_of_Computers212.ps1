
$computers = @("WSV000009","WSV000023","WSV000014","WSV000012","WSV000025","WSV000019","WSV000005","WSV000002","WSV000006","WSV000007","WS0003189","WSV000010","WSV000008",`
"WSV000015","WS000937","WSV000003","WS000177","WS0003176","WSV000004","WS002012","WS0003194","WSV000029","WS002010","WSV000024","WS000939","WSV000028","WSV000021",`
"WS002015","WS002014","WS0003184","WS0003193","WS0003196","WS0003181","WS0003179","WS002011","WS002012","WS000246")


$output = @()


foreach ($computer in $computers) {
    
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
        
        $monitorInfo = Invoke-Command -ComputerName $computer -ScriptBlock { Get-PnpDevice -Status 'OK' -Class 'Monitor' -FriendlyName 'Generic Non-PnP Monitor'}

        
        $userInfo = Invoke-Command -ComputerName $computer -ScriptBlock {quser}

        
        $output += $monitorInfo
        $output += $userInfo

    }  else {
        
        $output += "Computer $computer is offline"
        }
}


$output | Export-Csv -Path C:\temp\Monitor_Status.csv -NoTypeInformation
