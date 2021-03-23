#Michael Wagner
# $dcomputers = Get-Content C:\powershell\VMs.txt

Try {
New-Item -Path C:\powershell -ItemType "Directory" -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt
    }
Catch [System.IO.IOException] {Write-Host 'powershell Directory Already Exists' -ForegroundColor Black -BackgroundColor Cyan}
sleep 4
Get-LocalGroupMember -Name "administrators" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Try {
add-LocalGroupMember -Group administrators -Member va.gov\OITSVCVAECC -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
    }
Catch [Microsoft.PowerShell.Commands.MemberExistsException] {Write-Host 'Member already a member of the administrators group' -ForegroundColor Black -BackgroundColor Cyan}
sleep 5
Get-LocalGroupMember -Name "administrators" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Try {
Rename-NetAdapter -Name "Ethernet0" -NewName "PCCE Public" -ErrorAction Stop
    }
Catch [System.Exception] {Write-Host 'PCCE Public NIC is already named' -ForegroundColor Yellow -BackgroundColor DarkRed}
Sleep 5
Try {
Rename-NetAdapter -Name "Ethernet1" -NewName "PCCE Private" -ErrorAction Stop
    }
Catch [System.Exception] {Write-Host 'PCCE Private NIC is built on this VM' -ForegroundColor Yellow -BackgroundColor DarkRed} 
Sleep 4
Get-ExecutionPolicy | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-Date | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'CHECK FIPS Enabled is 0 or 1' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-ItemProperty -Path HKLM:\System\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy | Select-Object Enabled | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Hostname and stage R, U' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
[System.Net.Dns]::GetHostByName("$computer") | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage B' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-PSDrive | Where-Object {$_.Free -gt 1} | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage C'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WmiObject win32_logicaldisk -Filter drivetype=3 | select deviceID, filesystem | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-Volume | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage D' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Part of a domain? True or False:' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Host "'n" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage F'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'This windows update service should not be running '| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'The GPO used is AUTO/MANUAL - need to double check that for all servers no exceptions'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-Service -Name wuauserv | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage J'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WindowsFeature -Name SNMP-Service | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WindowsFeature -Name SNMP-WMI-Provider | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage K'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output ' change this here - right click>setting>advanced>performance>settings>advanced>change' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Then rerun this command manually - Get-WmiObject Win32_PageFileusage' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WmiObject Win32_PageFileusage | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage L'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'change this here - right click>setting>advanced>startup>settings' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 2
Write-Host "'n" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage M'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip -Name DisableTaskOffload -Value 1 | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 2
Write-Output 'stage N ckecks GPO if IPv6 is off'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters -Name "DisabledComponents" -Value "ff" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage O'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-TimeZone | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Write-Output 'stage P'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
w32tm /query /status | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Write-Output 'stage Q,Y'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
get-netadapter | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
netsh int ip show offload | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-NetAdapter | where-object {$_.Name} | Select-Object InterfaceDescription, MacAddress, LineSpeed | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage V, AE, AG'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-NetAdapterAdvancedProperty | Where-Object {$_.DisplayName -match "offload"} | Select-Object Name, DisplayName, DisplayValue | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-NetOffloadGlobalSetting -Chimney Disabled -TaskOffload Disabled -ReceiveSideScaling Disabled -NetworkDirect Disabled | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 2
Set-NetAdapterAdvancedProperty -DisplayName "IPv4 Checksum Offload" -DisplayValue "Disabled" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Set-NetAdapterAdvancedProperty -DisplayName "IPv4 TSO offload" -DisplayValue "Disabled" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Set-NetAdapterAdvancedProperty -DisplayName "Large send offload*" -DisplayValue "Disabled" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-NetAdapterAdvancedProperty -DisplayName "TCP checksum offload*" -DisplayValue "Disabled" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-NetAdapterAdvancedProperty -DisplayName "UDP checksum offload*" -DisplayValue "Disabled" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Set-NetAdapterAdvancedProperty -DisplayName "offload*" -DisplayValue "Disabled"
sleep 2
Get-NetAdapterAdvancedProperty | Where-Object {$_.DisplayName -match "offload"} | Select-Object Name, DisplayName, DisplayValue | out-file -filepath C:\powershell\$env:computername-staging.txt -Append


Write-Output 'stage Z'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WmiObject win32_networkadapterconfiguration | Select-Object IPAddress, DefaultIPGateway | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage Z, Public subnet should be 25'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage Z, Private subnet should be 27, if there is a second NIC'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-NetIPAddress | Select-Object IPAddress, PrefixLength | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

Write-Output 'stage AB'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
get-netadapterbinding | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Try {
Disable-NetAdapterBinding -Name "PCCE Private" -DisplayName "Client for Microsoft Networks" -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
    }
Catch [System.Exception] {Write-Output 'The PCCE Private NIC name is incorrect. You will have to fix and rerun'} # | out-file -filepath C:\powershell\$env:computername-staging.txt -Append

sleep 2

Try {
Disable-NetAdapterBinding -Name "PCCE Private" -DisplayName "File and Printer Sharing for Microsoft Networks" -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
    }
  
Catch [System.Exception] {Write-Output 'The PCCE Private NIC name is incorrect. You will have to fix and rerun'} #| out-file -filepath C:\powershell\$env:computername-staging.txt -Append

sleep 3
Write-Output 'Disable IP6 on public'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Try {
Disable-NetAdapterBinding -Name "PCCE Public" -ComponentID ms_tcpip6 -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
    }
Catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {Write-Host 'The PCCE Public NIC name is incorrect. Check your spelling' -ForegroundColor Yellow -BackgroundColor DarkRed} 
sleep 2
Write-Output 'Disable IP6 on Private'| out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Try {
Disable-NetAdapterBinding -Name "PCCE Private" -ComponentID ms_tcpip6 -ErrorAction Stop | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
    }
 
Catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {Write-Host 'The PCCE Private NIC name is incorrect or this VM only has 1 NIC which is ok' -ForegroundColor Yellow -BackgroundColor DarkRed}
sleep
get-netadapterbinding | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage W' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Public should be lower than Private' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Should be Public=1 and Private=2' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-NetIPInterface -InterfaceAlias "PCCE*" | Where-Object {$_.InterfaceMetric} | Select-Object InterfaceAlias, InterfaceMetric  | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage AC' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Clear-DnsClientCache | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Clear DNS Client Cache completed' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Host "'n" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'stage AD - Check Persistent Route' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
route print | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Write-Output 'stage AH' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -contains "VMware Tools"} | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 15
Write-Output 'Stage I - look for IIS' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Default Web Site shows up for all servers BUT the CVP and MEDIA Servers SHOULD have another listing' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'If the CVP or MEDIA servers only have a default web server that is an error' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Get-IISSite | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 2
Write-Host "'n" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output '========================' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'List of services running' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Get-Service | Where-Object {$_.Status -match 'Running'} | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 1
Write-Output 'Number of Services running is:' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
(Get-Service | Where-Object {$_.Status -match 'Running'}).count | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
sleep 10
Write-Output 'List of GPOs on this server' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
gpresult /Scope Computer /v | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Host "'n" | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
Write-Output 'Number of GPOs running are:' | out-file -filepath C:\powershell\$env:computername-staging.txt -Append
(gpresult /Scope Computer /v).count | out-file -filepath C:\powershell\$env:computername-staging.txt -Append


Write-Host 'John J or Klay please open the txt file in the powershell directory' -BackgroundColor Yellow -ForegroundColor Black
Write-Host 'Partial audit is completed!' -ForegroundColor Red -BackgroundColor Yellow