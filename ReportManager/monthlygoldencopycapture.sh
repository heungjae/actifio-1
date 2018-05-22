#!/bin/bash
# Actifio Copy Data Storage SARGPACK
# Copyright (c) 2016 Actifio Inc. All Rights Reserved
# This script collects reportpools checks
# Version 1.0 Initial Release
# Version 1.1 Added -n to SSH so SSH commands dont break out of the while loop
# Version 1.2 used sendmail to create HTML body
# Version 1.3 Add extra customization sections

################################################################################################
################   THE SECTION BELOW NEEDS TO BE CUSTOMIZED.   LEAVING AS DEFAULT WILL NOT WORK!
################################################################################################
#user name on each appliance.   You define this on each Actifio Appliance and use CLI to access
username=agmreport

# key location on the RM server.
# It is the private key that matches the public key assigned to every user on every Actifio Appliance
userkey=/dumps/keys/id_rsa

# destination for report  to be sent to
# You can place multiple email addresses in double quotes with a single comma between each address, example shown:
recipient="barbarar@au1.ibm.com"
blindrecipient="nab_alerts@actifio.com"
#recipient=
################################################################################################
################   THE SECTION ABOVE NEEDS TO BE CUSTOMIZED.   LEAVING AS DEFAULT WILL NOT WORK!
################################################################################################


#################################################################################################################
################   THE SECTION BELOW ONLY WORKS ON ACTIFIO RM   IF RUNNING ON YOUR OWN SERVER REMOVE THIS SECTION
#################################################################################################################
# EMAIL SERVER DISCOVERY SECTION.  We learn the mail server and THE FROM address from JasperSoft based RM

emailserver=$(cat /act/tomcat/webapps/jasperserver-pro/WEB-INF/js.quartz.properties | awk '/report.scheduler.mail.sender.host/ { print $3 }')
emailuser=$(cat /act/tomcat/webapps/jasperserver-pro/WEB-INF/js.quartz.properties | awk '/report.scheduler.mail.sender.from/ { print $3 }')

# grab list of clusters
clusterlist=$(/act/postgresql/bin/psql -t --no-align --field-separator '}' --pset footer actdb act -c "select clustername,ipaddress from clusterconfigdata")

#################################################################################################################
################   THE SECTION ABOVE ONLY WORKS ON ACTIFIO RM   IF RUNNING ON YOUR OWN SERVER REMOVE THIS SECTION
#################################################################################################################

#################################################################################################################
################   THE SECTION BELOW IS NEEDED IS YOU DONT USE AN RM
#################################################################################################################

#  UNHASH LINES BELOW AND CUSTOMIZE WITH YOUR EMAIL USER NAME AND SERVER NAME
# This is the 'from' email address used in this email and the email server that will forward our mail
# emailuser=anthonyv@actifio.com
# emailserver=192.43.242.5

# Put all your Appliance IDs in a file so they can be learned.   You could also just list them
# Format would be a list of IPs  in column format
# clusterlist=$(cat /root/clusterlist.txt)

#################################################################################################################
################   THE SECTION ABOVE IS NEEDED IS YOU DONT USE AN RM
#################################################################################################################



# check the list
if [ -z "$clusterlist" ]; then
	echo "There are no clusters defined to this RM"  > /root/$reportname
	exit
fi

# fetch the current date time
currentday=$(/bin/date +"%Y-%m-%d")
currentdate=$(/bin/date +"%Y-%m-%d %H:%M:%S %Z")
reportname="monthlygoldencopy_$currentday.txt"

# start the report output
echo "Report from Actifio Report Manager created on ${currentdate}" > /root/$reportname
echo "##################################################################################################################################################" >> /root/$reportname
# work the list
echo "$clusterlist" | while IFS="}" read -ra cluster; do
        reporthealthout=$(ssh -n -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $userkey $username@${cluster[1]} reportsnaps -d31 -f -c | awk -F"," '{ print $1","$5","$6","$9 }' | column -t -s, 2>/dev/null)
	if [ $? -ne 0 ]; then
		 echo "Failed to SSH to ${cluster[0]} using IP address ${cluster[1]} with username $username" >> /root/$reportname
	else
                 echo "Appliance: ${cluster[0]}" >> /root/$reportname
                 echo >> /root/$reportname
		 echo "$reporthealthout" >> /root/$reportname
	fi
        echo "----------------------------------" >> /root/$reportname
#	echo "--------------------------------------------------------------------------------" >> /root/$reportname
done
# use sendmail
(echo "To: $recipient"
echo "Bcc: $blindrecipient"
echo 'Subject: Actifio Database Monthly Golden Capture Summary
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=_myboundary"

--=_myboundary
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<html>
<body>
<pre style="font: monospace">'
cat /root/$reportname
echo '</pre>
</body>
</html>

--=_myboundary--') | /usr/sbin/sendmail -F "" -f $emailuser -t


# clean old report files that are older than one week
find /root -name "monthlygoldencopy_*.txt" -mtime +8 -exec rm -f {} \;
