## Introduction

How to install Actifio connector on a Linux host

### Setup

Install the Actifio connector from the Actifio appliance
```
yum -y localinstall http://10.65.5.193/connector-Linux-latestversion.rpm
```

Alternatively, download and install it:
```
curl -O http://172.24.50.42/connector-Linux-latestversion.rpm
rpm --checksig connector-Linux-latestversion.rpm             <-- Check the RPM package
rpm -ivh connector-Linux-latestversion.rpm	                 <-- To install the connector
```

List the installed package name
```
rpm ‐qa udsagent
```

Uninstall the package using rpm ‐e udsagent with the package name:
```
rpm ‐e connector‐Linux‐6.1.1.20857	
```

Disable the firewall:
```
service iptables stop
```

Ensure that the iscsi and iscsid services are automatically started in run level 3, 4 and 5:
```
chkconfig --list iscsi
chkconfig --list iscsid
```

List of udsagent related commands:
```
/etc/init.d/udsagent status
/etc/init.d/udsagent stop
/etc/init.d/udsagent start
/etc/init.d/udsagent restart

tail /var/act/log/UDSAgent.log
```
