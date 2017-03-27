#!/bin/bash
 
#==========================================
# Program   : /bin/update_yum_source.sh
# Info      : 定期同步官方 yum 源到本地
# Version   : 2014.12.15
# Usage     : 3 3 * * * /bin/bash /bin/update_yum_source.sh
#==========================================
 
Date=`date +%Y%m%d`
LogFile="/var/log/repo/$Date.log"
ReceiveMail="gmail.com"
 
RsyncBin="/usr/bin/rsync"
RsyncPerm="-avrt --delete --exclude=debug/  --exclude=isos/ --exclude=SRPMS/ --exclude=ppc/"
 
#============ centos ==============
CentOS_Path="/home/ftp/centos/6/"
YumSiteList="rsync://rsync.mirrors.ustc.edu.cn/centos/6/"
#centosparm="--exclude=2*/ --exclude=3*/ --exclude=4*/"
 
#============ epel ==============
#epelSite="rsync://mirrors.ustc.edu.cn/fedora-epel"
#epelLocalPath="/data/epel"
epelSite="rsync://mirrors.yun-idc.com/epel/6/x86_64"
epelLocalPath="/home/ftp/epel/6"
#epelparm="--exclude=4/ --exclude=4AS/ --exclude=4ES/ --exclude=4WS/"
 
#============ rpmforge ==============
#rpmforgeSite="rsync://apt.sw.be/pub/freshrpms/pub/dag/redhat/"
#rpmforgeSite="rsync://apt.sw.be/redhat/el6/en/x86_64"
rpmforgeSite="rsync://ftp.riken.jp/repoforge/redhat/el6/en/x86_64"
rpmforgeLocalPath="/home/ftp/rpmforge/el6/en"
#rpmforgeparm="--exclude=ppc/ --exclude=el2.1/ --exclude=el3/ --exclude=el4/"

#============ remi ==============
#remiSite="rsync://mirrors.hustunique.com/remi/enterprise/6/remi/x86_64"
#remiSite="rsync://mirrors.thzhost.com/remi/enterprise/6/remi/x86_64"
#remiLocalPath="/home/ftp/enterprise/6/remi/"
remiSite="rsync://mirrors.thzhost.com/remi/enterprise/6"
remiLocalPath="/home/ftp/enterprise/"
remiparm="--exclude=debug --exclude=ppc/ --exclude=el2.1/ --exclude=el3/ --exclude=el4/"
 
#============ percona ==============
perconaSite="rsync://rsync.percona.com/rsync/centos/6/"
perconaLocalPath="/home/ftp/percona/centos/6"
perconaparm="--exclude=debug "

echo "---- $Date `date +%T` Begin ----" >>$LogFile
 
# centos
$RsyncBin $RsyncPerm  $centosparm $YumSiteList $CentOS_Path >> $LogFile
 
# epel
$RsyncBin $RsyncPerm  $epelparm  $epelSite $epelLocalPath >> $LogFile
 
# rpmforge
$RsyncBin $RsyncPerm  $rpmforgeparm $rpmforgeSite $rpmforgeLocalPath >> $LogFile
# remi
$RsyncBin $RsyncPerm  $remiparm $remiSite $remiLocalPath >> $LogFile

# percona
$RsyncBin $RsyncPerm $perconaparm $perconaSite $perconaLocalPath >> $LogFile

 
echo  "---- $Date `date +%T` End ----" >> $LogFile
 
#/bin/mail -s "opt001 - update yum source - $Date" $ReceiveMail<$LogFile

