#!/bin/sh
PWD=/usr/local/etc/rsync/rsync.snd
SRC=/web_test
DST=file@10.0.2.12::web_test/
/usr/local/bin/rsync -avRz --password-file=$PWD --delete $SRC $DST
