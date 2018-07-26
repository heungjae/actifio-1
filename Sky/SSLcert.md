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

On the client:
```
echo -n | openssl s_client -connect 10.65.5.193:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ./melnabsky.cert
```

Mac OS
```
sudo security add-trusted-cert -d -r trustRoot -k $HOME/Library/Keychains/login.keychain ./melnabsky.cert 
sudo security delete-certificate -c "<name of existing certificate>"
```

You need to perform the following steps to add certificates to the Trusted Root Certification Authorities store for a local computer:

Windows
```
Click Start, click Start Search, type mmc, and then press ENTER.
On the File menu, click Add/Remove Snap-in.
Under Available snap-ins, click Certificates, and then click Add.
Under This snap-in will always manage certificates for, click Computer account, and then click Next.
Click Local computer, and click Finish.
If you have no more snap-ins to add to the console, click OK.
In the console tree, double-click Certificates.
Right-click the Trusted Root Certification Authorities store.
Click Import to import the certificates and follow the steps in the Certificate Import Wizard.
```
