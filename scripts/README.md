### README

A direct mount is to take “last image” and mount it to a host. Pre and Post script can be included as part of the process. For Linux target, use bash scripts.

There are two way to run a workflow:
1) initial provisioning of an image
2) refresh a provisioned database with the latest image


```
Post: wf_post.sh /oracle/admin/actifio/script/run_postrefresh.ksh^X3STAR
Timeout: 10800
```

File: wf.post.sh
```
scriptpath=$2
if [ ! -z "$scriptpath" ] && [ "x$scriptpath" != "x" ]; then
scriptname=`echo "$scriptname" | awk -F"^" '{print $(NF-1)}'`
ORACLESID=`echo "$scriptname" | awk -F"^" '{print $(NF)}'`
fi
```

```
#  sudo -i is equal to su -
#  sudo -i simulates a login into the root account: your working directory will be /root, 
#      and root's .profile etc. will be sourced as if on login.
#      The -s flag tells sqlplus to be banner silent and not prompt for any input 
#           such as username/password or variable substitution
```

```
You need to source the oracle_env.sh shell file created by the installation of the Oracle Database during the installation. You have two approaches to source the environment file, the first approach is with a dot (.), like

. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
or, this

source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
The oracle_env.sh file contains the following:

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export PATH=$ORACLE_HOME/bin:$PATH
Now, you can connect to the Oracle Database as the internal user with the following command:

sqlplus / as sysdba
```
