Hometask #3 (19/09)
AWS task:
- create repo hometask3
- create AWS VM using ami-01bc990364452ab3e (AWS Linux) with aws-cli (like a hometask2 BUT
  NOT THE SAME! Please do not mix two tasks!)
- configure cron job (/etc/crontab/...) which write every minute on workdays (Mon-Fri) next
  information to log file /var/log/sysinfo :
- current system time and date; (use date command)
- system uptime, logged-in users and CPU load; (use w command) - memory usage and disk space usage; (use free -m and df -h )
- list of programs used open TCP ports; (ss -tulpn)
- check connection to ukr.net host; (ping -c1 -w1 ukr.net )
- list of SUID programs in local system. (find see options in man)
  Tips:
- best way is to create script /root/sysinfo.sh ran by cron job. Do not forget make your script executable (use chmod).
- AWS Linux does not contain cron daemon by default. You need to install it (the name of package is cronie)

## How to start: 
aws ec2 run-instances \
--image-id ami-01bc990364452ab3e \
--count 1 \
--instance-type t2.micro \
--user-data file://cron.sh \
--region us-east-1 --output json