#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx
cat <<'EOF' >/usr/share/nginx/html/index.html
<html>
<head><title>Resume</title></head>
<body>
<h1>Tushar Kumar - Resume</h1>
<p>This is a sample resume hosted on EC2 with Nginx.</p>
</body>
</html>
EOF
