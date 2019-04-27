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
