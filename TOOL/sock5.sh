wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/3proxy-0.9.4.x86_64.deb
sudo dpkg -i 3proxy-0.9.4.x86_64.deb
sudo sh -c 'printf "#!/bin/3proxy\n#daemon\n\n\n# Cấu hình chung cho 3proxy\ndaemon\nmaxconn 100\nnserver 8.8.8.8\nnscache 65536\ntimeouts 1 5 30 60 180 1800 15 60\n\n# Thêm thông tin xác thực người dùng\nusers hoanglong:CL:van@123\n\n# Cấu hình SOCKS5 server trên cổng 18822 với yêu cầu xác thực\nsocks -p18822 -i0.0.0.0 -e0.0.0.0 -a\n" > /etc/3proxy/3proxy.cfg'
3proxy /etc/3proxy/3proxy.cfg
