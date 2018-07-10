#### How to create a self-signed certificate

```
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
```

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

Remove passphrase from key (for nGinx):
```
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
rm server.key.org
```

Generate the certificate server request (CSR):
```
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

List the generated CSR:
```
openssl req -text -noout -verify -in /etc/nginx/ssl/server.csr
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
cd /act/certs
cp /etc/nginx/ssl/server.crt nginx.cert
cp /etc/nginx/ssl/server.key nginx.key
```

Restart the nginx server:
```
service nginx restart
```



##### Furthter automation:

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

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/myssl.key \
    -out /etc/ssl/certs/myssl.crt


openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/myssl.key \
    -out /etc/ssl/certs/myssl.crt <<EOF
AU
Adelaide

Acme Project
POC
adlagm.localhost

EOF
```
