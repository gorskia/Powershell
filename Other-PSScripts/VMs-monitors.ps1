$line = 1..18
foreach ($line in (Get-Content -Path D:\Users\mmoev\Desktop\'TSDCORPHYPV04 VMs.txt')) {

    Invoke-Command -ComputerName $Server -ScriptBlock { Get-PnpDevice -Class 'Monitor'}
}
'------------------------------------------------------------------------------------------------------------------------'
Write-Host End of foreach loop