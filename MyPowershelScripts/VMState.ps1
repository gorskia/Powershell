### Created by Mihail Moev ### 
#----------------------------#


# Get the VM information and select the Name, State, and Uptime properties
$vmInfo = Get-VM -ComputerName TSDCORPHYPV04,TSDCORPHYPV05 | Select-Object Name, State, Uptime 

# Convert the VM information to an HTML table with three columns
$table = $vmInfo | ConvertTo-Html -Fragment -PreContent "<!DOCTYPE html>
<html>
<style>
table, th, td {
  border:1px solid black;
}
td.Running {
    background-color: green;
}
td.Off {
    background-color: red;
}
</style>
<body>

<h2>Current status of all Remote Virtual Machines</h2>

</body>" -PostContent "</table>" -Property Name, State, Uptime 

#if(State -eq 'Running'){'green'}else{'red'}

'<p><span>Best regards</span>,<br><span><b>IT TSD TEAM.</b></span></p>

</body>'

# Output the HTML table
$table


# Send Mail from .csv report 
Start-Sleep -Second 8

$table = $table.Replace("{tabledata}", $tableData)

# Define a variable with a list of recipients
$recipients = ("mmoev@tsd.com, ppavlov@tsd.com, abelevski@tsd.com")

$smtpServer = "tsdcorpshar01"
$smtpFrom = "IT-TSD@tsd.com"
#$smtpTo = "ppavlov@tsd.com, mmoev@tsd.com, abelevski@tsd.com"
$messageSubject = "ServerStatus"

$mail = New-Object System.Net.Mail.Mailmessage $smtpFrom,$recipients,$messagesubject,$table
$mail.IsBodyHTML=$true

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($mail)