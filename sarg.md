## Overview ##

### List of report commands ###

```
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

reportsnaps -c -d 7
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
```
