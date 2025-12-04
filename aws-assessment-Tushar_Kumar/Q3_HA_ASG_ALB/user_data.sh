#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx
cat <<'EOF' >/usr/share/nginx/html/index.html
<html><body><h1>Autoscaled app - Hello from $(hostname)</h1></body></html>
EOF
