# Define the list of computers to check for updates
$computers = Get-Content -Path "C:\computerlist.txt"

# Loop through each computer and check for updates
foreach ($computer in $computers) {
  # Check for updates
  Invoke-Command -ComputerName $computer -ScriptBlock {
    Set-Service -Name wuauserv -StartupType Manual
  }

  #Invoke-Command -ComputerName $computer -ScriptBlock {
   # Install-Module PSWindowsUpdate
  #}
  
  Invoke-Command -ComputerName $computer -ScriptBlock {
    Get-WindowsUpdate -verbose -AcceptAll -Install -AutoReboot
  }

  # Install any updates that were found
  #if ($updates) {
   # $updates | Invoke-WindowsUpdate -Install -IgnoreReboot
  }

