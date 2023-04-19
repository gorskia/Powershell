#Prurpose of this scrip is to check the healt of the Important Servers.
#Hide the folder with the script

#attrib +h +s C:\SWSetup

#HTML BODY

 
[string]$messagebody = '
<!DOCTYPE html>
<html>
<style>
table, th, td {
  border:1px solid black;
}
</style>
<body>

<h2>Current status of all Remote Virtual Desktop</h2>

<table style="width:100%">
  <tr>
    <th>Server Name</th>
    <th>Status</th>
    <th>Up Time</th>
   </tr>
   
  {tabledata}
  
</table>

<p><span>Best regards</span>,<br><span><b>IT TSD TEAM.</b></span></p>

</body>'
 
#Path of the file with Servers that need to be checked.

$ServersList="c:\ServersList_U.txt"
        # Get Servers List
        #
        $ServerNames = Get-Content $ServersList
        
        [string]$rowTemplate = '   
        <tr>
            <td>{server}</td>
            <td style="color:{color}">{status}</td>
            <td style="color:{color}">{uptime}</td>
        </tr>'

        [string]$tableData = ''

        #
        # Loop Each Server and do ping test once
        #
        foreach ($ServerName in $ServerNames) {
            
            $currentdate = Get-Date
            $ServerStatus = "Down"
            $StatusColor = "red"
            if (Test-Connection -ComputerName $ServerName -Count 1  -ErrorAction SilentlyContinue) {
            # Write Node Up, delimited by tab
            $ServerStatus = "Up"
            $StatusColor = "green"       
            }
            #$Uptime = Get-CimInstance -ClassName Win32_OperatingSystem | Select LastBootUpTime
            $Bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ServerName).LastBootUpTime
            $uptime = $currentdate - $Bootuptime
            Write-output $Bootuptime
            Write-Output "$ServerName Uptime : $($uptime.Days) Days, $($uptime.Hours) Hours, $($uptime.Minutes) Minutes"
            #style="color:{color}"
            $tableData += $rowTemplate.Replace("{server}", $ServerName).Replace("{status}", $ServerStatus).Replace("{color}", $StatusColor).Replace("{uptime}", $Bootuptime)


                # -replace "{server}", $ServerName `
                # -replace "{status}", $ServerStatus + "`r`n"
            
            #     $messagebody = $messagebody + $Server + "`r`n" 
             
            # $messagebody = $messagebody.Replace('{tabledata}',$tableData)
 
            }

# Send Mail from .csv report # 

Start-Sleep -Second 8

$messagebody = $messagebody.Replace("{tabledata}", $tableData)

# Define a variable with a list of recipients
$recipients = ("mmoev@tsd.com")

$smtpServer = "tsdcorpshar01"
$smtpFrom = "IT-TSD@tsd.com"
#$smtpTo = "ppavlov@tsd.com, mmoev@tsd.com, abelevski@tsd.com"
$messageSubject = "ServerStatus"

$mail = New-Object System.Net.Mail.Mailmessage $smtpFrom,$recipients,$messagesubject,$messagebody
$mail.IsBodyHTML=$true

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($mail)



