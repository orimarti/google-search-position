#!/bin/bash

if ! S3CMD=`which s3cmd`;
    then
    >&2 echo "s3cmd command not found, please install it"
    exit 1;
fi 

if ! CARTON=`which carton`;
    then
    >&2 echo "carton command not found, please install it"
    exit 1;
fi 
TMP_DIR=/var/tmp/google-search

if [[ -a $TMP_DIR && ! -d $TMP_DIR ]];
    then
    >&2 echo "$TMP_DIR is not a directory!!"
    exit 1;
fi
    
if [ ! -e $TMP_DIR ];
    then
    mkdir $TMP_DIR
fi
LOCK_FILE=/var/tmp/google-search/lock-$2
if [[ ! -a $LOCK_FILE ]];
then
  touch -d "$(date -d "25 hours ago" +"%Y-%m-%d %H:%M:%S")" $LOCK_FILE
fi
onedaysec="86400"
last_exec=$(ls -l --time-style +%s $LOCK_FILE | awk '{print $6}')
now=$(date +%s)
time_difference=$(echo $now-$last_exec|bc)

if [[ $time_difference -lt $onedaysec ]];then
  exit 0
fi

basename=`dirname $0`

s3_dir=$1


$S3CMD get $s3_dir/$2 $TMP_DIR/$2 --force

cd $basename/..
$CARTON install >/dev/null 
echo -ne $(date +%Y%m%d-%H%M) >> $TMP_DIR/$2
echo -ne " - " >> $TMP_DIR/$2
perl -I ./local/lib/perl5/ ./get_position.pl --api_key $3 --web_page $4 --query_string $5 --search_engine $6 >> $TMP_DIR/$2
echo "" >> $TMP_DIR/$2

$S3CMD put $TMP_DIR/$2 $s3_dir/$2


touch $LOCK_FILE
