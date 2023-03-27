D:\Users\mmoev\Desktop\VMs-state-check.ps1 -ComputerName TSDCORPHYPV04, TSDCORPHYPV05 | Export-Csv C:\Temp\VMs-State.txt
#Start-Sleep -s 30
$SmtpServer = "tsdcorpshar01.tsd.com"
$EmailFrom = "TSDCORPHYPV04/05 <mmoev@tsd.com>"
$EmailTo = "mmoev@tsd.com"
$EmailSubject = "Get VMs State - Daily Report on: "+$ReportDate
$attachment = "C:\Temp\VMs-State.txt"
Send-MailMessage -To $EmailTo -From $EmailFrom -Subject $EmailSubject -BodyAsHTML -Attachments $attachment -SmtpServer $SmtpServer