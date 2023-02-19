#!/bin/bash

declare -a arr=( "lx5-test" "lx8" "app6" "app7" "app8" "app9" "app10" "dr7")
if [ ! -d ~/s3fs ]; then
  mkdir ~/s3fs;
fi

for i in ${arr[@]}; do
 echo -e "\033[30;7m==============================================================================================\e[0m"
 echo "This is host $i"
 /usr/bin/ssh $i df -h | grep 's3fs'
 echo "This is host $i" >> ~/s3fs/s3fs-$(date +%HH@%d-%m-%Y).log
 /usr/bin/ssh $i df -h | grep 's3fs' >> ~/s3fs/s3fs-$(date +%HH@%d-%m-%Y).log 
done
  notify-send "s3fsCheck.sh has been ran check your logs"
