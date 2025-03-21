# Tạo thư mục tạm để lưu các file cài đặt
$downloadPath = "$env:TEMP\Downloads"
New-Item -ItemType Directory -Path $downloadPath -Force

Write-Host "Tải xuống file cài đặt Node.js, Python và Brave Browser..." -ForegroundColor Green

# Tải file Python
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe" -OutFile "$downloadPath\python-3.10.6-amd64.exe"

# Tải file Brave Browser
Invoke-WebRequest -Uri "https://referrals.brave.com/latest/BraveBrowserSetup-BRV010.exe" -OutFile "$downloadPath\BraveBrowserSetup-BRV010.exe"

Write-Host "Tải xuống hoàn tất." -ForegroundColor Green


Write-Host "Cài đặt Python..." -ForegroundColor Green
# Cài đặt Python
Start-Process -FilePath "$downloadPath\python-3.10.6-amd64.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

Write-Host "Cài đặt Brave Browser..." -ForegroundColor Green
# Cài đặt Brave Browser
Start-Process -FilePath "$downloadPath\BraveBrowserSetup-BRV010.exe" 


# Cập nhật lại biến môi trường PATH trong phiên PowerShell hiện tại
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
Write-Host "Cập nhật PATH hoàn tất. Giờ đây bạn có thể sử dụng npm và pip mà không cần khởi động lại console." -ForegroundColor Green

Write-Host "Cài đặt các gói Python..." -ForegroundColor Green
# Cài đặt các gói Python
pip install psutil==6.1.0 PyAutoGUI==0.9.54 requests pytz

Write-Host "Cài đặt hoàn tất." -ForegroundColor Green

Write-Host "Dọn dẹp các file tạm..." -ForegroundColor Yellow
# Dọn dẹp các file tạm
Remove-Item -Path $downloadPath -Recurse -Force

Write-Host "Quá trình hoàn tất. Tất cả các gói đã được cài đặt thành công!" -ForegroundColor Green
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

