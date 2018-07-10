#### How to create a self-signed certificate

```
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
```

##### Option 1: Generating private key and CSR
Generating an SSL private key to sign the server certificate. Enter `password` for the passphrase for server.key:
```
openssl genrsa -des3 -out server.key 2048
```

View the server certificate:
```
cat /etc/nginx/ssl/server.key
```

Generating a certificate signining request:
```
openssl req -new -key server.key -out server.csr
```

List the generated CSR:
```
openssl req -text -noout -verify -in /etc/nginx/ssl/server.csr
```

Remove passphrase from key (for nGinx) so that the following signing doesn't prompt for a password:
```
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
rm server.key.org
```

##### Option 2: Automating generating private key and CSR

Generate the private server key and CSR:
```
openssl req -new -sha256 -nodes -out /etc/nginx/ssl/server.csr -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -config <(
cat <<-EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = v3_req
x509_extensions = usr_cert
distinguished_name = dn
 
[ dn ]
C=AU
ST=Victoria
L=Melbourne
O=Acme
OU=IT Security
emailAddress=johndoe@acme.com
CN = melagm
 
[ v3_req ]
subjectAltName = @alt_names

[ usr_cert ]
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, codeSigning

[ alt_names ]
DNS.1 = melagm
DNS.2 = localhost
IP.1 = 10.65.5.195
EOF
)
```

##### Signing CSR and generating server certificate

Sign the certificate server request (CSR):
```
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

Display the content of the signed certificate (PEM) format:
```
openssl x509 -in /etc/nginx/ssl/server.crt -noout -text
```

Find out the location of the key and signed certificate:
```
cat /act/emsrv/nginx_server.conf
```

Backup the original key and certificates:
```
cp server.crt server.crt.bak
cp server.key server.crt.org
```

Copy the files to the location specified in /act/emsrv/nginx_server.conf file:
```
cp /etc/nginx/ssl/server.crt /act/certs/nginx.cert
cp /etc/nginx/ssl/server.key /act/certs/nginx.key
```

Confirm there is no syntax errors in the nginx configuration file:
```
nginx -t
```

Restart the nginx server:
```
service nginx restart
```

###### Generating private key and signing certificate
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ssl2.key \
    -out /etc/nginx/ssl/ssl2.crt
```

###### Automating generating private key and CSR
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ssl4.key \
    -out /etc/nginx/ssl/ssl4.crt <<EOF
AU
Adelaide

Acme Project
POC
adlagm.localhost

EOF
```


##### Certificate conversion

The following certificate file formats:

Linux:  
1) PEM is a base64 encoded certificate placed between the headers -----BEGIN CERTIFICATE----- and -----END CERTIFICATE-----. It is the most widespread certificate format, which is mostly used by Linux-based servers, like Apache, Nginx. PEM certificates may have the following file extensions: *.pem, *.crt, *.cer. 


Windows:  
2) PKCS#7 is another certificate with Base64 encoding that is used generally by Windows and Java-based Tomcat servers, and may contain domain end-entity certificate and CA chain certificates. If you open a PKCS#7 file in a text editor, you can see the encoded text between -----BEGIN PKCS7----- and -----END PKCS7----- tags. The most common extensions are: *.p7b, *.p7s, *.cer.

3) PKCS#12/PFX is a file in binary format that contains the certificate with a corresponding private key and is protected by a password. Optionally, the file can include the CA chain certificates as well. Usually, PFX certificates are used on Windows machines, and are essential for transferring the certificate from one Windows server to another. The file extensions are: *.p12 and *.pfx.


From PEM to PKCS#7
```
openssl crl2pkcs7 -nocrl -certfile your_pem_certificate.crt -out your_pkcs7_certificate.p7b -certfile CA-bundle.crt
```

From PKCS#7 to PEM
```
openssl pkcs7 -print_certs -in your_pkcs7_certificate.p7b -out your_pem_certificates.pem
```

If PKCS#7 file included the chain certificates, the newly generated .pem file would include them as well, separately.

From PEM to PFX
```
openssl pkcs12 -export -out your_pfx_certificate.pfx -inkey your_private.key -in your_pem_certificate.crt -certfile CA-bundle.crt
```

You will be also prompted to specify the password for the PFX file. Make sure you remember the password, it will be used when you need to import the PFX to a new server.

From PFX to PEM
```
openssl pkcs12 -in your_pfx_certificate.pfx -out your_pem_certificates_and_key.pem -nodes
```

You will be asked to specify the password that was used when creating the PFX file you are converting. The obtained PEM file will contain the certificate, chain certificates (optionally) and the private key.

From PKCS#7 to PFX

To convert a certificate from PKCS#7 to PFX, the certificate should be first converted into PEM:
```
openssl pkcs7 -print_certs -in your_pkcs7_certificate.p7b -out your_pem_certificates.pem
```

After that, the certificate can be converted into PFX.
```
openssl pkcs12 -export -out your_pfx_certificate.pfx -inkey your_private.key -in your_pem_certificate.crt
```
