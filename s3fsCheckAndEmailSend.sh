#!/bin/bash

declare -a arr=( "lx5-test" "lx8" "app6" "app7" "app8" "app9" "app10")

declare -a hosts=()
msg="$The host is missing s3fs filesystem please report it!"

for i in ${arr[@]}; do
 if [[ "$i" =~ ^lx[0-9]+(-test)?$ ]] ; then
   if ! /usr/bin/ssh $i df -hT /data/backup/lxd >> /dev/null;then
	   XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "$i $msg";
	   hosts+=$i" /data/backup/lxd is missing      "
   fi
 
   if ! /usr/bin/ssh $i df -hT /data/backup/nginx >> /dev/null;then
	   XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "$i $msg";
	   hosts+=$i" /data/backup/nginx is missing      "
   fi  
    
  elif ! /usr/bin/ssh $i df -h | grep -q 's3fs'; then
           XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "$i $msg";
 
	hosts+=$i" is missing        " 
 fi 
done
if [ ${#hosts[@]} -gt 0 ]; then
echo  "${hosts[@]}" | mail -s "The host failed to present s3fs"  salih.bimbash@notolytix.com
fi
