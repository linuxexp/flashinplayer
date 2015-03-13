#!/bin/bash
#
# FlashInPlayer
#
# Will iterate through all open copies of flashplayer and 
# will open them in totem or specified player

echo "FlashInPlayer (C) Raja, <www.experiblog.co.cc>"

pids=`eval pgrep -f flashplayer`

for pid in $pids
do
output=$(lsof -p $pid | grep '/tmp/Flash[^ ]*')

IFS=$'\n'
for line in $output; do
filename=`echo $line | awk '{print "/proc/" $2 "/fd/" $4}' | sed 's/[rwu]$//'`

if [ -n "$1" ];then
$1 $filename
else
totem $filename
fi

done
done
