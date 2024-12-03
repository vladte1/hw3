#!/bin/bash

sudo yum update -y
sudo yum install -y aws-cli cronie

cat << 'EOF' | sudo tee /root/sysinfo.sh
#!/bin/bash
{
    echo "System Information Log - $(date)"
    echo "----------------------------------"
    echo "Current Date and Time: $(date)"
    echo "System Uptime and Users:"
    w
    echo "----------------------------------"
    echo "Memory and Disk Usage:"
    free -m
    df -h
    echo "----------------------------------"
    echo "Open TCP Ports:"
    ss -tulpn
    echo "----------------------------------"
    echo "Checking connection to ukr.net:"
    ping -c1 -w1 ukr.net &>/dev/null && echo "Ping successful" || echo "Ping failed"
    echo "----------------------------------"
    echo "SUID Programs:"
    find / -perm -4000 2>/dev/null
} >> /var/log/sysinfo
EOF

sudo chmod +x /root/sysinfo.sh

echo '* * * * 1-5 root /root/sysinfo.sh' | sudo tee -a /etc/crontab

sudo systemctl start crond
sudo systemctl enable crond

echo "Setup complete. The script will run every minute on weekdays and log to /var/log/sysinfo."
