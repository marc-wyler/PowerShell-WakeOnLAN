function Send-WOL
{

[CmdletBinding()]
param(
[Parameter(Mandatory=$True,Position=1)]
[string]$mac,
[string]$ip, 
[int]$port=7 #Port 7 is the standard otherwise Port 9
)
 
$mac=(($mac.replace(":","")).replace("-","")).replace(".","")
$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)}
$packet = (,[byte]255 * 6) + ($target * 16)
 
$UDPclient = new-Object System.Net.Sockets.UdpClient
$UDPclient.Connect($ip,$port)
[void]$UDPclient.Send($packet, 102)
}

# Wake Up 
send-WOL -mac XX-XX-XX-XX-XX-XX -ip 192.168.1.255 #enter MAC- and Broadcast-Address
Start-Sleep -s 12 #wait between the signals
send-WOL -mac XX-XX-XX-XX-XX-XX -ip 192.168.1.255
Start-Sleep -s 12
send-WOL -mac XX-XX-XX-XX-XX-XX -ip 192.168.1.255
Start-Sleep -s 12
send-WOL -mac XX-XX-XX-XX-XX-XX -ip 192.168.1.255