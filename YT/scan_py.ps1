# Tạo thư mục tạm để lưu các file cài đặt
$downloadPath = "$env:TEMP\Downloads"
New-Item -ItemType Directory -Path $downloadPath -Force

Write-Host "Tải xuống file cài đặt Node.js, Python và Brave Browser..." -ForegroundColor Green

# Tải file Python
#Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe" -OutFile "$downloadPath\python-3.10.6-amd64.exe"
#Invoke-WebRequest -Uri "https://www.proxifier.com/download/ProxifierSetup.exe" -OutFile "$downloadPath\ProxifierSetup.exe"
# Tải file Brave Browser
#Invoke-WebRequest -Uri "https://referrals.brave.com/latest/BraveBrowserSetup-BRV010.exe" -OutFile "$downloadPath\BraveBrowserSetup-BRV010.exe"
#Invoke-WebRequest -Uri "https://github.com/trangtrau/random-agent-spoofer/raw/refs/heads/master/YT/chrome_setup.exe" -OutFile "$downloadPath\chrome_setup.exe"
#Invoke-WebRequest -Uri "https://www.dropbox.com/scl/fi/4457f7aymgul350cxkuuo/nimo_tool.zip?rlkey=k0kq9xacj3132qchb1p9armft&st=up6tpxiu&dl=1" -OutFile "$downloadPath\nimo_tool.zip"
#Invoke-WebRequest -Uri "https://www.dropbox.com/scl/fi/19n0o7j4p8ssstopg1wba/gpm.zip?rlkey=l365fzib20c9aa4de22ak091x&st=ayrmum3v&dl=1" -OutFile "$downloadPath\gpm.zip"

Write-Host "Tải xuống hoàn tất." -ForegroundColor Green
Write-Host "Cài đặt Brave Browser..." -ForegroundColor Green
# Cài đặt Brave Browser

#Start-Process -FilePath "$downloadPath\chrome_setup.exe" -ArgumentList "/silent /install" -Wait
#Start-Process -FilePath "$downloadPath\ProxifierSetup.exe" -ArgumentList "/silent" -Wait
#Start-Process -FilePath "$downloadPath\BraveBrowserSetup-BRV010.exe" -ArgumentList "/silent /install" -Wait
Write-Host "Cài đặt Python..." -ForegroundColor Green
# Cài đặt Python
Start-Process -FilePath "$downloadPath\python-3.10.6-amd64.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait


#$destination = Join-Path -Path ([Environment]::GetFolderPath("Desktop")) -ChildPath "Nimo"
#$destination2 = Join-Path -Path ([Environment]::GetFolderPath("Desktop")) -ChildPath "GPM"

#Expand-Archive -Path "$downloadPath\nimo_tool.zip" -DestinationPath $destination -Force
Expand-Archive -Path "$downloadPath\gpm.zip" -DestinationPath $destination2 -Force

# Cập nhật lại biến môi trường PATH trong phiên PowerShell hiện tại
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
Write-Host "Cập nhật PATH hoàn tất. Giờ đây bạn có thể sử dụng npm và pip mà không cần khởi động lại console." -ForegroundColor Green


@"
asyncio
json
time
re
os
base64
random
shutil
uuid
tkinter
typing
gspread
google-auth
pytz
requests
aiofiles
pathlib
psutil
playwright
urllib3
zipfile
subprocess
"@ | Out-File -FilePath "requirements.txt" -Encoding UTF8; pip install -r requirements.txt



Write-Host "Quá trình hoàn tất. Tất cả các gói đã được cài đặt thành công!" -ForegroundColor Green

$services = @("gupdate", "gupdatem")
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled
}

# 2. Tắt các tác vụ tự động cập nhật trong Task Scheduler
$schedulerTasks = @(
    "\GoogleUpdateTaskMachineCore",
    "\GoogleUpdateTaskMachineUA"
)
foreach ($task in $schedulerTasks) {
    schtasks /Change /TN $task /Disable 2>$null
}
