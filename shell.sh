#! /bin/bash

username="root" #server username
server_ip=94.237.92.78    #server ip address
path_to_destination="~/Desktop/test/" #destination address in the server
location=DNS_PCAP/
pass=""


if ! [ -d temp ] 
then
mkdir temp
fi

find $location -type f | 
while read -r i
do 
ServerName=`echo $i | cut -d / -f3`
editcap -i 300 $i temp/$ServerName

ls temp |
while read -r s
do

ServerName=`echo $s | cut -d _ -f1`

Year=`echo $s | cut -d _ -f 3 | cut -d . -f 1 | cut -c 1-4`

Month=`echo $s | cut -d _ -f 3 | cut -d . -f 1 | cut -c 5-6`

Day=`echo $s | cut -d _ -f 3 | cut -d . -f 1 | cut -c 7-8`

Hour=`echo $s | cut -d _ -f 3 | cut -d . -f 1 | cut -c 9-10`

Minutes=`echo $s | cut -d _ -f 3 | cut -d . -f 1 | cut -c 11-12`

file="${ServerName}_${Year}-${Month}-${Day}_${Hour}:${Minutes}.pcap"


mv temp/$s temp/${file}
sshpass -p $pass scp temp/$file $username@$server_ip:$path_to_destination

echo "$file ... done"

sleep 5 

rm temp/$file

done


done




<<COMMENT1

echo "Enter the password of $username@$server_ip :" ; read -s pass;

status=$(sshpass -p $pass ssh -o ConnectTimeout=10 $username@$server_ip echo ok 2>&1)
if [[ $status == ok ]] ; then
  echo auth ok, 
####
ls sample | 
while read -r file
do

sshpass -p $pass scp sample/$file $username@$server_ip:$path_to_destination
echo "$file ... done"

done
####
elif [[ $status == "Permission denied"* ]] ; then
  echo no_auth
else
  echo Time OUT
fi

COMMENT1

