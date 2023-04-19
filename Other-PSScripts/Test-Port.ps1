<#
	.SYNOPSIS
		This function tests for open TCP/UDP ports.
	.DESCRIPTION
		This function tests any TCP/UDP port to see if it's open or closed.
	.NOTES

	.PARAMETER Computername
		One or more remote, comma-separated computer names
	.PARAMETER Port
		One or more comma-separated port numbers you'd like to test.
	.PARAMETER TcpTimeout
		The number of milliseconds that the function will wait until declaring
		the TCP port closed. Default is 1000.
	.EXAMPLE
		PS> Test-Port -Computername 'LABDC','LABDC2' -Protocol TCP 80,443
		
		This example tests the TCP network ports 80 and 443 on both the LABDC
		and LABDC2 servers.
	#>
[CmdletBinding()]
[OutputType([System.Management.Automation.PSCustomObject])]
param (
    [Parameter(Mandatory)]
    [string[]]$ComputerName,
    [Parameter(Mandatory)]
    [int[]]$Port,
    [Parameter()]
    [int]$TcpTimeout = 1000
)
begin {
    $Protocol = 'TCP'
}
process {
    foreach ($Computer in $ComputerName) {
        foreach ($Portx in $Port) {            
            $Output = @{ 'Computername' = $Computer; 'Port' = $Portx; 'Protocol' = $Protocol; 'Result' = '' }
            Write-Verbose "$($MyInvocation.MyCommand.Name) - Beginning port test on '$Computer' on port '$Protocol<code>:$Portx'"

            $TcpClient = New-Object System.Net.Sockets.TcpClient
            $Connect = $TcpClient.BeginConnect($Computer, $Portx, $null, $null)
            $Wait = $Connect.AsyncWaitHandle.WaitOne($TcpTimeout, $false)
            if (!$Wait -or !($TcpClient.Connected)) {
                $TcpClient.Close()
                Write-Verbose "$($MyInvocation.MyCommand.Name) - '$Computer' failed port test on port '$Protocol</code>:$Portx'"
                $Output.Result = $false
            }
            else {
                $TcpClient.EndConnect($Connect)
                $TcpClient.Close()
                Write-Verbose "$($MyInvocation.MyCommand.Name) - '$Computer' passed port test on port '$Protocol<code>:$Portx'"
                $Output.Result = $true
                $TcpClient.Close()
                $TcpClient.Dispose()
            }
            [pscustomobject]$Output
        }
    }
}