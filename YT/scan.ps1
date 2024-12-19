# Tạo thư mục tạm để lưu các file cài đặt
$downloadPath = "$env:TEMP\Downloads"
New-Item -ItemType Directory -Path $downloadPath -Force

Write-Host "Tải xuống file cài đặt Node.js, Python và Brave Browser..." -ForegroundColor Green

# Tải file Node.js
Invoke-WebRequest -Uri "https://nodejs.org/dist/v20.18.1/node-v20.18.1-x64.msi" -OutFile "$downloadPath\node-v20.18.1-x64.msi"

# Tải file Python
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe" -OutFile "$downloadPath\python-3.10.6-amd64.exe"

# Tải file Brave Browser
Invoke-WebRequest -Uri "https://referrals.brave.com/latest/BraveBrowserSetup-BRV010.exe" -OutFile "$downloadPath\BraveBrowserSetup-BRV010.exe"

Write-Host "Tải xuống hoàn tất." -ForegroundColor Green

Write-Host "Cài đặt Node.js..." -ForegroundColor Green
# Cài đặt Node.js
Start-Process -FilePath "$downloadPath\node-v20.18.1-x64.msi" -ArgumentList "/quiet" -Wait

Write-Host "Cài đặt Python..." -ForegroundColor Green
# Cài đặt Python
Start-Process -FilePath "$downloadPath\python-3.10.6-amd64.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

Write-Host "Cài đặt Brave Browser..." -ForegroundColor Green
# Cài đặt Brave Browser
Start-Process -FilePath "$downloadPath\BraveBrowserSetup-BRV010.exe" -ArgumentList "/silent" -Wait

Write-Host "Cài đặt Node.js, Python và Brave Browser hoàn tất." -ForegroundColor Green

# Cập nhật lại biến môi trường PATH trong phiên PowerShell hiện tại
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
Write-Host "Cập nhật PATH hoàn tất. Giờ đây bạn có thể sử dụng npm và pip mà không cần khởi động lại console." -ForegroundColor Green

Write-Host "Cài đặt các gói NPM..." -ForegroundColor Green
# Cài đặt các gói NPM
npm install axios@1.7.7 child_process@1.0.2 fs-extra@11.2.0 googleapis@143.0.0 luxon@3.5.0 path@0.12.7 puppeteer@23.2.1

Write-Host "Cài đặt các gói Python..." -ForegroundColor Green
# Cài đặt các gói Python
pip install psutil==6.1.0 PyAutoGUI==0.9.54 requests pytz

Write-Host "Cài đặt hoàn tất." -ForegroundColor Green

Write-Host "Dọn dẹp các file tạm..." -ForegroundColor Yellow
# Dọn dẹp các file tạm
Remove-Item -Path $downloadPath -Recurse -Force

Write-Host "Quá trình hoàn tất. Tất cả các gói đã được cài đặt thành công!" -ForegroundColor Green
