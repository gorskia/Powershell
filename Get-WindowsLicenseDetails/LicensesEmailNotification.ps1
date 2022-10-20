C:\Temp\Get-WindowsLicenseDetails.ps1 -ComputerName TSDSOFTDHYD02,TSDSOFTDHYD04,TSDSOFTSHYD01,TSDSOFTTHYD02 | Export-Csv C:\Temp\info.csv
#Start-Sleep -s 30
$SmtpServer = "tsdcorpshar01.tsd.com"
$EmailFrom = "TSDCORPHYPV03 <abelevski@tsd.com>"
$EmailTo = "mmoev@tsd.com"
$EmailSubject = "Site Delete Script - Daily Report on: "+$ReportDate
$attachment = "C:\Temp\info.csv"
Send-MailMessage -To $EmailTo -From $EmailFrom -Subject $EmailSubject -BodyAsHTML -Attachments $attachment -SmtpServer $SmtpServer