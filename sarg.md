## Overview ##

### List of report commands ###

```
To list all applications that are or should be consuming MDL (formerly reportmdlusage):
reportapps -a 0

reportpools -c
PoolName,FreeSpaceGiB,UsedSpaceGiB,PoolSizeGiB,PoolSize7DaysAgoGiB,UsageToday%,Usage1DayAgo%,Usage7DaysAgo%,Warn%,Safe%,Status,CompressionRatio,pooltype
act_ded_pool000 (5 TiB Max Size),845.92,17.68,863.60,0,2,2,0,88,100,Normal,n/a,Dedup
act_per_pool000,494.00,2.00,496.00,0,0,0,0,80,90,Normal,5.23x,Perf
act_pri_pool000,92.09,6.34,98.43,0,6,6,0,80,90,Normal,1.94x,Primary

reportpoolhistory -c
Poolname,Date,PoolSize(GB),UsedSize(GB),Used%
act_ded_pool000,2018-04-10 03:00:00,864,18,2
act_ded_pool000,2018-04-11 03:00:00,864,18,2
act_ded_pool000,2018-04-12 03:00:00,864,18,2
act_per_pool000,2018-04-10 03:00:00,496,0,0
act_per_pool000,2018-04-11 03:00:00,496,1,0
act_per_pool000,2018-04-12 03:00:00,496,2,0
act_pri_pool000,2018-04-10 03:00:00,98,6,6
act_pri_pool000,2018-04-11 03:00:00,98,6,6
act_pri_pool000,2018-04-12 03:00:00,98,6,6

To list all the snapshot jobs performed (default last 2 days), look for the change rate and amount of data copied:
# reportsnaps -c -d 3
StartDate,JobName,JobClass,PolicyName,HostName,AppName,AppID,Duration,CaptureType,VirtSize(GB),AppSize(GB),DataCopied(GB),ChangeRate%,ExpirationDate
2018-04-09 20:29:36,Job_0005446c,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:03:31,FullCopy(ASM),50.000,1.6,1.698,107.70,2018-04-11 20:33:07
2018-04-09 21:08:34,Job_0005545,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:02:11,Incremental(ASM),50.000,1.6,0.030,1.90,2018-04-11 21:10:39
2018-04-09 22:22:33,Job_0005638,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:03:20,Incremental(ASM),50.000,1.6,0.041,2.61,2018-04-11 22:25:52
2018-04-10 09:25:58,Job_0007108,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:02:31,Incremental(ASM),50.000,1.6,0.084,5.30,2018-04-12 09:28:23
2018-04-10 16:18:51,Job_0007343,snapshot(DB),Production to Snap 1,"melnaborcl","vdemo",6684,00:02:00,FullCopy(ASM),50.000,2.1,0.075,3.54,2018-04-12 16:20:50
2018-04-10 19:00:00,Job_0008103,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:02:10,Incremental(ASM),50.000,1.6,0.081,5.09,2018-04-12 19:02:09
2018-04-11 12:14:15,Job_0009903,snapshot(DB),Production to Snap 1,"melnaborcl","wdemo",9253,00:07:11,FullCopy(ASM),50.000,1.6,2.271,142.94,2018-04-13 12:21:23
2018-04-11 19:00:00,Job_0010520,snapshot,Production to Snap 1,"melnaborcl","demo",5211,00:02:21,Incremental(ASM),50.000,1.6,0.085,5.37,2018-04-13 19:02:18

reportsnappool -c -d 7
AppType,HostName,AppName,AppID,SourceCluster,Template,Profile,Poolname,Vols,AppSize(GB),VDisks,Stage(GB),Snap(GB),Logs(GB),Mount(GB),Mirror(GB),LiveClone(GB),Rehydrate(GB),Clone(GB),Total(GB)
Oracle,"melnaborcl","demo",5211,melnabsky.local,SnapOnly,LocalProfile,act_per_pool000,1,1.6,3,0.495,0.035,0.000,0.000,0.000,0.000,0.000,0.000,0.529 
Oracle,"melnaborcl","wdemo",9253,melnabsky.local,OrphanApp,OrphanApp,act_per_pool000,1,1.6,5,0.491,0.000,0.005,0.000,0.000,0.491,0.000,0.000,0.988 

reportdedups -c -d 7

reportstats -c -d 7
StartDate,JobName,JobClass,PolicyName,HostName,AppName,AppID,Duration,VirtSize(GB),AppSize(GB),DataCopied(MB),BytesRead(MB),WroteLocal(MB),TotalSent(MB)
2018-04-09 20:29:36,Job_0005446c,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:03:31,50.000,1.6,1738.296,0.000,0.000,0.000
2018-04-09 21:08:34,Job_0005545,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:02:11,50.000,1.6,30.670,0.000,0.000,0.000
2018-04-09 22:22:33,Job_0005638,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:03:20,50.000,1.6,42.158,0.000,0.000,0.000
2018-04-10 09:25:58,Job_0007108,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:02:31,50.000,1.6,85.586,0.000,0.000,0.000
2018-04-10 16:18:51,Job_0007343,snapshot(DB),"Production to Snap 1","melnaborcl","vdemo",6684,00:02:00,50.000,2.1,76.394,0.000,0.000,0.000
2018-04-10 19:00:00,Job_0008103,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:02:10,50.000,1.6,82.645,0.000,0.000,0.000
2018-04-11 12:14:15,Job_0009903,snapshot(DB),"Production to Snap 1","melnaborcl","wdemo",9253,00:07:11,50.000,1.6,2325.304,0.000,0.000,0.000
2018-04-11 19:00:00,Job_0010520,snapshot,"Production to Snap 1","melnaborcl","demo",5211,00:02:21,50.000,1.6,87.302,0.000,0.000,0.000

reportapps -c -d 7
AppType,HostName,AppName,AppID,Template,Profile,Ignored,VirtSize(GB),MDLStat(GB),VDisks,Stage(GB),Snaps(GB),Total(GB),Dedups,PostCompress(GB),LastExpirationDate
Oracle,"melnaborcl","demo",5211,SnapOnly,LocalProfile,false,50.0,1.589,4,0.563,0.000,0.563,0,0.000,2018-04-13 19:02
Oracle,"melnaborcl","wdemo",9253,OrphanApp,OrphanApp,Orphan,50.0,1.589,0,0.000,0.000,0.000,0,0.000,2100-01-01 00:00

reportpolicies -c
TemplateID,TemplateName,PolicyID,PolicyName,TotalApps,Operation,Priority,Retention,AppConsistency,LogProtection,LogTruncation,Starts,Ends,RunsEvery,RunInformation,ExceptInformation
5246,SnapOnly,5267,Production to Snap 1,1,snap,medium,2days,no,no,no,19:00,07:00,24hours,Everyday,n/a

reportconsumption -c
AppID,HostName,AppName,SnapData(GB),SnapLogs(GB),SnapMounts(GB),Dedup(GB),DedupChildren(GB)
5211,"melnaborcl","demo", 0.529, 0.000, 0.000, 0.000, 0.000
9253,"melnaborcl","wdemo", 0.492, 0.005, 0.000, 0.000, 0.000

reportrpo -c
AppType,HostName,AppName,AppID,Template,Profile,AppSize(GB),RPO(mins),LogsDate,SnapshotDate,DirectDedupDate,DedupDate,RemoteDedupDate,ProdMirror,LiveCloneDate,OnVaultDate
Oracle,"melnaborcl","demo",5211,SnapOnly,LocalProfile,1.6,-,-,2018-04-11 19:00,-,-,-,-,-,- 

reportfctree -c
AppType,HostName,AppName,AppID,MountedHost,Label,vDiskType,vDiskName,DiskPool,UsedCapacity(GB),TotalCapacity(GB),CreationDate,CompressionRatio
Oracle,"melnaborcl","demo",5211,"-","-","StagingDisk",vm-5ACB40B75C00,act_per_pool000,0.495,50.000,2018-04-09 20:30:15,4.21x
Oracle,"melnaborcl","demo",5211,"-","-","_Snapshot",fc-5ACC7D775200,act_per_pool000,0.034,50.000,2018-04-10 19:01:43,4.25x
Oracle,"melnaborcl","demo",5211,"-","-","_Snapshot",fc-5ACDCEFF3D00,act_per_pool000,0.000,50.000,2018-04-11 19:01:51,4.21x
Oracle,"melnaborcl","wdemo",9253,"-","-","StagingDisk",vm-5ACD6F970D00,act_per_pool000,0.491,50.000,2018-04-11 12:14:47,5.73x
Oracle,"melnaborcl","wdemo",9253,"-","-","_Snapshot",fc-5ACD70723B00,act_per_pool000,0.000,50.000,2018-04-11 12:18:26,5.73x
Oracle,"melnaborcl","wdemo",9253,"-","-","LogStagingDisk",vm-5ACD70E00E00,act_per_pool000,0.005,10.000,2018-04-11 12:20:16,45.47x
Oracle,"melnaborcl","wdemo",9253,"-","-","_LogSnapshot",fc-5ACD71114900,act_per_pool000,0.000,10.000,2018-04-11 12:21:05,45.47x
Oracle,"melnaborcl","wdemo",9253,"-","LC01","LiveClone",vm-5ACD725C0300,act_per_pool000,0.491,50.000,2018-04-11 12:26:36,5.73x

reportjobs -c
StartDate,JobName,JobClass,Status,PolicyName,HostName,AppName,AppID,Duration
2018-04-10 16:18:51,Job_0007343,snapshot(DB),succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:02:00
2018-04-10 16:21:17,Job_0007405,liveclone,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:50
2018-04-10 16:22:54,Job_0007507,unmount,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:03:00
2018-04-10 16:26:40,Job_0007802,delete,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:10
2018-04-10 16:30:00,Job_0007979,delete,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:10
2018-04-10 16:30:21,Job_0007998,expiration,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:20
2018-04-10 19:00:00,Job_0008103,snapshot,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:10
2018-04-11 11:29:47,Job_0008913,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:09:10
2018-04-11 11:43:02,Job_0009392,unmount,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:52
2018-04-11 11:50:41,Job_0009661,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:51
2018-04-11 12:14:15,Job_0009903,snapshot(DB),succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:07:11
2018-04-11 12:26:34,Job_0009949,liveclone,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:00:40
2018-04-11 12:30:03,Job_0010014,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:03:01
2018-04-11 12:46:27,Job_0010128,mount,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:01:12
2018-04-11 12:54:22,Job_0010155,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:12
2018-04-11 13:01:04,Job_0010233,mount,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:01:12
2018-04-11 14:44:10,Job_0010320,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:20
2018-04-11 14:48:54,Job_0010355,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:09:21
2018-04-11 15:01:59,Job_0010422,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:03
2018-04-11 19:00:00,Job_0010520,snapshot,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:21
2018-04-11 20:33:21,Job_0010554,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-11 21:10:55,Job_0010571,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-11 22:26:04,Job_0010598,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-12 09:28:36,Job_0010868,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:10

reportrunningjobs
reportfailedjobs
reportfailedjobs -a 10234

## To output the failed job and includes the "udstask backup" command at the end. It already has the correct appid and 
## policy id included. Then add "-options noparent" to the end of the command if the job failed with a fingerprint error.
reportfailedjobs -c -p 

# To count number of successful jobs completed in each class. Some types are grouped into categories:
reportjobcount -c
Event,Count
delete Jobs,2 
expiration Jobs,5 
liveclone Jobs,2 
mount Jobs,5 
snapshot Jobs,4 
unmount-delete Jobs,4 
unmount Jobs,2 

reportimages -a0 -c
ImageName,JobClass,HostName,AppName,AppID,AppSize(GB),ConsistencyDate,EndPIT,ExpirationDate,SourceCluster,Label
Image_0008103,snapshot,"melnaborcl","demo",5211,1.584,2018-04-10 19:00:44,n/a,2018-04-12 19:02:09,melnabsky.local,"" 
Image_0010520,snapshot,"melnaborcl","demo",5211,1.589,2018-04-11 19:00:48,n/a,2018-04-13 19:02:18,melnabsky.local,"" 
Image_0009903,snapshot,"melnaborcl","wdemo",9253,1.589,2018-04-11 12:15:48,n/a,2018-04-13 12:21:23,melnabsky.local,"" 
Image_0009949,liveclone,"melnaborcl","wdemo",9253,1.589,2018-04-11 12:15:48,n/a,2100-01-01 00:00:00,melnabsky.local,"LC01" 

reportfabric -i -c
HostName,HostID,HostType,HostIQN,HostIPs,eth0:10.65.5.193
melnaborcl,5205,Linux,iqn.1988-12.com.oracle:a2677fd2e7a,10.65.5.190,10.65.5.190

## To list all jobs for protected applications
reportjobs -c
StartDate,JobName,JobClass,Status,PolicyName,HostName,AppName,AppID,Duration
2018-04-10 16:18:51,Job_0007343,snapshot(DB),succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:02:00
2018-04-10 16:21:17,Job_0007405,liveclone,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:50
2018-04-10 16:22:54,Job_0007507,unmount,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:03:00
2018-04-10 16:26:40,Job_0007802,delete,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:10
2018-04-10 16:30:00,Job_0007979,delete,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:10
2018-04-10 16:30:21,Job_0007998,expiration,succeeded,Production to Snap 1,"melnaborcl","vdemo",6684,00:00:20
2018-04-10 19:00:00,Job_0008103,snapshot,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:10
2018-04-11 11:29:47,Job_0008913,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:09:10
2018-04-11 11:43:02,Job_0009392,unmount,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:52
2018-04-11 11:50:41,Job_0009661,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:51
2018-04-11 12:14:15,Job_0009903,snapshot(DB),succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:07:11
2018-04-11 12:26:34,Job_0009949,liveclone,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:00:40
2018-04-11 12:30:03,Job_0010014,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:03:01
2018-04-11 12:46:27,Job_0010128,mount,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:01:12
2018-04-11 12:54:22,Job_0010155,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:12
2018-04-11 13:01:04,Job_0010233,mount,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:01:12
2018-04-11 14:44:10,Job_0010320,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:20
2018-04-11 14:48:54,Job_0010355,mount(AppAware),succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:09:21
2018-04-11 15:01:59,Job_0010422,unmount-delete,succeeded,Production to Snap 1,"melnaborcl","wdemo",9253,00:03:03
2018-04-11 19:00:00,Job_0010520,snapshot,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:02:21
2018-04-11 20:33:21,Job_0010554,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-11 21:10:55,Job_0010571,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-11 22:26:04,Job_0010598,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:11
2018-04-12 09:28:36,Job_0010868,expiration,succeeded,Production to Snap 1,"melnaborcl","demo",5211,00:00:10

reportmdlusage -c
AppType,HostName,AppName,AppID,Template,Profile,Ignored,VirtSize(GB),MDLStat(GB),VDisks,Stage(GB),Snaps(GB),Total(GB),Dedups,PostCompress(GB),LastExpirationDate
Oracle,"melnaborcl","demo",5211,SnapOnly,LocalProfile,false,50.0,1.589,4,0.563,0.000,0.563,0,0.000,2018-04-13 19:02
Oracle,"melnaborcl","wdemo",9253,OrphanApp,OrphanApp,Orphan,50.0,1.589,0,0.000,0.000,0.000,0,0.000,2100-01-01 00:00
reportmdlusage -cx

To list mount, prep-mount and remote-mount jobs in the last two days
## reportmounts -c ##
StartDate,JobName,JobClass,Status,SourceHost,SourceApp,SourceAppID,TargetHost,Duration,VirtualSize(GB),ApplicationSize(GB)
2018-04-11 11:29:47,Job_0008913,mount(AppAware),Succeeded,"melnaborcl","demo",5211,"melnaborcl",00:09:10,50.000,1.584
2018-04-11 11:50:41,Job_0009661,mount(AppAware),Succeeded,"melnaborcl","demo",5211,"melnaborcl",00:02:51,50.000,1.584
2018-04-11 12:46:27,Job_0010128,mount,Succeeded,"melnaborcl","wdemo",9253,"melnaborcl",00:01:12,50.000,1.589
2018-04-11 13:01:04,Job_0010233,mount,Succeeded,"melnaborcl","wdemo",9253,"melnaborcl",00:01:12,50.000,1.589
2018-04-11 14:48:54,Job_0010355,mount(AppAware),Succeeded,"melnaborcl","wdemo",9253,"melnaborcl",00:09:21,50.000,1.589

## To list all active mounts
reportmountedimages

reportsnappool -xvc
AppType,HostName,AppName,AppID,SourceCluster,Template,Profile,Poolname,Vols,AppSize(GB),VDisks,Stage(GB),Snap(GB),Logs(GB),Mount(GB),Mirror(GB),LiveClone(GB),Rehydrate(GB),Clone(GB),Total(GB)
Oracle,"melnaborcl","demo",5211,melnabsky.local,SnapOnly,LocalProfile,act_per_pool000,1,1.6,3,0.495,0.035,0.000,0.000,0.000,0.000,0.000,0.000,0.529 
Oracle,"melnaborcl","wdemo",9253,melnabsky.local,OrphanApp,OrphanApp,act_per_pool000,1,1.6,5,0.491,0.000,0.005,0.000,0.000,0.491,0.000,0.000,0.988 
UsageTotals(GB),-,-,-,-,-,-,-,-,-,8,0.986,0.035,0.005,0.000,0.000,0.491,0.000,0.000,1.518 
VDiskCount,-,-,-,-,-,-,-,-,-,8,2,3,2,0,0,1,0,0,8 

reporthealth

reportdailyfailures
reportcanceledjobs
reportconsumption
reportstats

```

## Tips and Tricks

```
# Hide the subjobs
reportrunningjobs -p

# Show me mounting from onvault
reportmounts -o onvault

# Show me system recovery
reportmounts -j systemrecovery 

# show me system recovery from onvault
reportmounts -j systemrecovery -d100 -o onvault

# default sorts by Apptype then Hostname then Appname
reportworkflows

# -t option sorts by target host. So if you know a host is seeing mounts, you can easily see the workflow
reportworkflows -t

# -w option sorts by workflow name
reportworkflows -w

# reportrbac can be used to analyse, offload and document the setup of roles and orgs on an Actifio Appliance or AGM
reportrbac

cat /dumps/workflows.txt | /usr/sbin/sendmail -F "nab-workflows-vip5" aaron.tully@actifio.com 

# reportmailer -e michael.chew@actifio.com -r /reportfailedjobs -d9,reportrpo/
```

```
reportimages had -r option added to show remote images
reportremoteimages was changed to simply run this:   reportimages -r $@

reportadvancedpolicies has been replaced by:  reportadvancedsettings
reportbackups has been replaced by:   reportimages
reportclonevdisks has been replaced by reportclonedisks
reportconnectoroptions has been replaced by: reportadvancedsettings 
reportcons has been replaced by: reportpo
reportmdlusage has been replaced by:  reportapps
reportorphanapps has been replaced by: reportapps 
reportorphanimages has been replaced by: reportimages
reportremoteimages has been replaced by:  reportimages 
reportvaults has been replaced by:   reportonvaults


## Past reports:
reportclones            Report all clone jobs.  Filter by recent days, or by recent days and app id
reportdaily             Report the quantity of jobs that were run for each app for each type
reportdailyfailures     Report quantities of failed jobs for each application
reportdedupasyncs       Report 2 days of dedupasync jobs.  Filter by recent days, or by recent days and app id
reportdedups            Report 7 days of dedup jobs.  Filter by recent days, or by recent days and app id
reportdirectdedups      Report 7 days of direct2dedup jobs.  Filter by recent days, or by recent days and app id
reportexpires           Report 2 days of expiration jobs.  Filter by recent days, or by recent days and app id
reportfailedjobs        Report 2 days of failed jobs.  Filter by recent days, or by recent days and app id
reportjobs              Report 2 days of jobs.  Filter by recent days, or by recent days and app id
reportjobcount          Report how many successful jobs of each class occurred
reportliveclones        Report 2 days of liveclone jobs.  Filter by recent days, or by recent days and app id
reportmounts            Report all mount jobs.  Filter by recent days
reportpoolhistory       Report on pool space history
reportremotededups      Report 7 days of remote dedup jobs.  Filter by recent days, or by recent days and app id
reportrestores          Report all restore jobs.  Filter by recent days
reportsnaps             Report 2 days of snapshot jobs.  Filter by recent days, or by recent days and app id
reportstats             Report 2 days of backup jobs.  Filter by recent days, or by recent days and app id
reportsweeps            Report all sweep jobs or optionally all Garbage Collection and sweep jobs
reportweekly            Report on backups that exist in the pools from the last seven days


## Latest:
reportapps              Report all protected applications sorted by app type, then hostname and appname
reportappcount          Count all applications and show protection status
reportbackups           List all backup images in each pool
reportconnectors        Report all connector versions.  Display help with -h to get update commands
reportcons              Report the most recent image for each type for each protected application
reportdedupratio        Report on the ratio of total backup size to dedup pool size
reportdisables          Report all applications that have scheduling or expiration disabled
reporteverything        Report as many details as possible about each application.  CSV output only
reportimages            Lists the quantity of images available for each application
reportmdiskspace        Report on how the MDisks are used in the pools
reportmountedimages     Report all mounted images active in the system
reportperfstats         Report on node IOPS, throughput and response times
reportpolicies          Report all in-use policies, including number of apps using each one
reportpools             Report on pool space consumption
reportremoteimages      Report all backup images resident in an Actifio that originated externally
reportrunningjobs       Report all jobs currently running in the system
reportsnappool          Report on the space usage of the snap pool
reportunprotected       Report all apps that don't have an SLA
reportvdisks            Report on how VDisks are being used by the system
reportvms               Report on VM discovery status
```
