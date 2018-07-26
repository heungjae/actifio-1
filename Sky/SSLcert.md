#### Introduction

File: genkey.sh
```
#!/bin/bash
outfile=/act/certs/output.txt
ls -la /act/certs/.keystore* >> $outfile
file=".keystore-`date +'%Y-%m-%d'`"
echo "mv /act/certs/.keystore $file" >> $outfile


/act/jre/bin/keytool -genkey -dname "C=AU,S=Vic,L=Melbourne,CN=melnabsky" -alias tomcat -keyalg RSA -keystore /act/certs/.keystore1 -storepass actifio1 -keypass actifio1 -keysize 2048 -sigalg SHA256withRSA
/act/jre/bin/keytool -import -noprompt -trustcacerts -keystore /act/certs/.keystore1 -storepass actifio1 -alias tc -file /act/certs/uds.pem
/act/jre/bin/keytool -list -keystore /act/certs/.keystore1 -storepass actifio1 

ls -la /act/certs/.keystore* >> $outfile
mv /act/certs/.keystore /act/certs/$file
mv /act/certs/.keystore1 /act/certs/.keystore
chmod 0600 /act/certs/.keystore
chown act:act /act/certs/.keystore

monit stop tomcat
monit start tomcat

cat $outfile
```
