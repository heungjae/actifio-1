## Introduction

How to install Actifio connector on a Linux host

### Setup

Install the Actifio connector from the Actifio appliance
```
yum -y localinstall http://10.65.5.204/connector-Linux-latestversion.rpm
```

Alternatively, download and install it:
```
curl -k -O http://172.24.50.42/connector-Linux-latestversion.rpm
rpm --checksig connector-Linux-latestversion.rpm             <-- Check the RPM package
rpm -ivh connector-Linux-latestversion.rpm	                 <-- To install the connector
```

List the installed package name
```
rpm ‐qa udsagent
```

Verify the connector is running:
```
/etc/init.d/udsagent status
```

Ensure the Actifio connector is running
```
ps -ef | grep udsagent
```

Uninstall the package using rpm ‐e udsagent with the package name:
```
rpm ‐e connector‐Linux‐6.1.1.20857	
```

Disable the firewall:
```
service iptables stop
```

Display the status of the current firewall settings :  
```
service iptables status 
```

Insert (-i) a firewall rule for the Actifio connector : 
```
iptables -I INPUT -i eth0 -p tcp -s <CDS-IP>/32 --dport 5106 -j ACCEPT  
iptables -I OUTPUT  -p tcp --sport 5106 -j ACCEPT  
iptables -I INPUT -i eth0 -p tcp -s <CDS-IP>/32 --dport 56789 -j ACCEPT 
iptables -I OUTPUT  -p tcp --sport 56789 -j ACCEPT
```

On the Linux host, confirm the ports are opened between the two hosts: 
```
netstat –ano | grep 5106 
netstat –ano | grep 56789
```

Confirm the firewall ports are opened by running the following command from the Actifio appliance:
```
telnet <Linux-IP> 5106 
telnet <Linux-IP> 56789
```

Turn on the iscsi and iscsid services for default run level 2, 3, 4 and 5:
```
chkconfig iscsi on
chkconfig iscsid on
chkconfig --level 345 iscsi on
```

Ensure that the iscsi and iscsid services are automatically started in run level 3, 4 and 5:
```
chkconfig --list iscsi
chkconfig --list iscsid
```

To make it persistent, save the changes to /etc/config/iptables by running:
```
service iptables save
```

Reload the iptables and restart the firewall service:
```
service iptables restart
```

To disable the firewall:
```
service iptables stop
```

List of udsagent related commands:
```
/etc/init.d/udsagent status
/etc/init.d/udsagent stop
/etc/init.d/udsagent start
/etc/init.d/udsagent restart

tail -f /var/act/log/UDSAgent.log
```
