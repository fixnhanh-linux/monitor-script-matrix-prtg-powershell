<h1 align="center">📡 Monitor Script Matrix PRTG PowerShell</h1>

<p align="center">
  <img src="https://img.shields.io/badge/PRTG-17.13+-blue?style=for-the-badge" alt="PRTG Support">
  <img src="https://img.shields.io/badge/Matrix-Webhook-green?style=for-the-badge" alt="Matrix">
  <img src="https://img.shields.io/badge/PowerShell-5.1+-informational?style=for-the-badge" alt="PowerShell">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License">
</p>

<p align="center">
  <img src="assets/banner.png" alt="Banner" width="80%">
</p>

<hr>

<h2>📖 Giới thiệu</h2>
<p>
Script này giúp <b>PRTG Network Monitor</b> gửi cảnh báo tự động tới <b>Matrix Server</b> thông qua PowerShell và Batch file.  
Thông báo có thể được tùy biến màu sắc, icon và nội dung dựa trên mức cảnh báo.
</p>

<ul>
  <li>🔴 Critical (Đỏ) khi lỗi nghiêm trọng</li>
  <li>🟠 Warning (Cam) khi cảnh báo</li>
  <li>🟢 OK (Xanh) khi trạng thái phục hồi</li>
</ul>

<hr>

<h2>📋 Yêu cầu hệ thống</h2>
<ul>
  <li>PRTG Network Monitor phiên bản 17.13 hoặc mới hơn</li>
  <li>Windows Server hoặc PRTG Probe (hỗ trợ PowerShell)</li>
  <li>Matrix Server đã cấu hình Webhook hoặc Access Token</li>
  <li>PowerShell 5.1+ (đảm bảo máy hỗ trợ)</li>
  <li>Quyền chạy script PowerShell:
    <pre>Set-ExecutionPolicy RemoteSigned</pre>
  </li>
</ul>

<hr>

<h2>📂 Cấu trúc thư mục</h2>
<pre>
monitor-script-matrix-prtg-powershell/
│
├── Script_Matrix_Prtg.ps1
├── PRTG_Matrix_Notification.bat
├── README.md
└── assets/
    ├── banner.png
    ├── prtg-matrix-flow.png
    ├── notification-critical.png
    ├── notification-ok.png
</pre>

<hr>

<h2>⚙️ Cấu hình Script</h2>

<h3>1️⃣ Chỉnh sửa <code>Script_Matrix_Prtg.ps1</code></h3>
<pre>
# URL Matrix Webhook
$MatrixWebhook = "https://matrix.example.org/_matrix/client/r0/rooms/!RoomID/send/m.room.message?access_token=YOUR_ACCESS_TOKEN"

# Màu thông báo
$ColorCritical = "red"
$ColorWarning  = "orange"
$ColorOk       = "green"
</pre>

<h3>2️⃣ Chỉnh sửa <code>PRTG_Matrix_Notification.bat</code></h3>
<pre>
@echo off
powershell -ExecutionPolicy Bypass -File "C:\Scripts\Script_Matrix_Prtg.ps1" %1 %2 %3 %4 %5 %6 %7
</pre>
<p>📌 Lưu ý: Chỉnh lại đường dẫn tới file <code>Script_Matrix_Prtg.ps1</code> nếu đặt ở vị trí khác.</p>

<hr>

<h2>🔗 Tích hợp với PRTG</h2>
<ol>
  <li>Mở <b>PRTG Web Interface</b></li>
  <li>Đi tới <b>Setup</b> → <b>Account Settings</b> → <b>Notification Templates</b></li>
  <li>Nhấn <b>+ Add Notification Template</b></li>
  <li>Chọn <b>Execute Program</b></li>
  <li>Program File:
    <pre>PRTG_Matrix_Notification.bat</pre>
  </li>
  <li>Tham số truyền vào:
    <pre>%device %name %status %datetime %lastvalue %lastmessage %probe %group</pre>
  </li>
  <li>Lưu template và gán vào sensor / device cần cảnh báo</li>
</ol>

<hr>

<h2 align="center">📊 Luồng hoạt động</h2>
<p align="center">
  <img src="assets/prtg-matrix-flow.png" alt="Flow PRTG → Matrix" width="80%">
</p>

<hr>

<h2>🛠 Ví dụ thông báo</h2>

<h3>🔴 Critical</h3>
<p align="center">
  <img src="assets/notification-critical.png" alt="Critical Notification" width="70%">
</p>

<h3>🟢 OK</h3>
<p align="center">
  <img src="assets/notification-ok.png" alt="OK Notification" width="70%">
</p>

<hr>

<h2>💡 Mẹo và Tối ưu</h2>
<ul>
  <li>Luôn kiểm tra URL Webhook Matrix hoạt động bằng cách gửi thử từ Postman hoặc curl</li>
  <li>Dùng thông số PRTG chính xác để tránh lỗi parse dữ liệu</li>
  <li>Gán template cho nhóm (Group) thay vì từng sensor để dễ quản lý</li>
  <li>Có thể thêm emoji tùy ý vào nội dung thông báo trong script PowerShell</li>
</ul>

<hr>

<h2>📜 Giấy phép</h2>
<p>MIT License © 2025 <b>FixNhanh Linux</b></p>

<hr>

<h2>❤️ Hỗ trợ và Đóng góp</h2>
<ul>
  <li>🌟 Star repo nếu thấy hữu ích</li>
  <li>🐛 Mở Issue nếu gặp lỗi</li>
  <li>🤝 Đóng góp Pull Request nếu muốn cải tiến</li>
</ul>
