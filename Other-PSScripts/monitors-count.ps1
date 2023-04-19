$Serverlist= "WSV000009","WSV000023","WSV000014","WSV000012","WSV000025","WSV000019","WSV000005","WSV000002","WSV000006","WSV000007","WS0003189","WSV000010","WS000294","WSV000008",`
"WSV000015","WS000937","WSV000003","WS000177","WS0003176","WSV000004","WS002012","WS0003194","WSV000029","WS002010","WSV000024","WS000939","WSV000028","WSV000021",`
"WS002015","WS002014","WS0003184","WS0003193","WS0003196","WS0003181","WS0003179","WS002011","WS002012","WS000246"



foreach ($Server in $Serverlist){
 
    Invoke-Command -ComputerName $Server -ScriptBlock {Get-PnpDevice -Status 'OK' -Class 'Monitor' -FriendlyName 'Generic Non-PnP Monitor'}
    Invoke-Command -ComputerName $Server -ScriptBlock {quser}
    '------------------------------------------------------------------------------------------------------------------------------------------------------'
    '______________________________________________________________________________________________________________________________________________________'
  }


#Select-Object PSComputerName, User, FriendlyName, Status | Export-csv C:\Temp\Get_Monitor_Status.csv -NoTypeInformation

#Out-File -FilePath D:\Users\mmoev\Desktop\employees-monitor-count.txt

#If (Test-Connection $server -count 1 -quiet)