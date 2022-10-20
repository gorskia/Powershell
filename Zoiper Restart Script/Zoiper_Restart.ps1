Get-Process -Name Zoiper5 | Stop-Process -Force
Start-Sleep -s 20
Start-Process -FilePath 'C:\Program Files (x86)\Zoiper5\Zoiper5.exe'