#! /bin/bash
 
username="root" #server username
server_ip=94.237.92.78    #server ip address
path_to_destination="~/Desktop/test/" #destination address in the server
location=$1
pass=""

if [ $# -ne 1 ]; then
echo "Usage: ./shell.sh target/"
exit 1
fi
 
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
Date=`capinfos -Tra temp/$s | cut -d " " -f2-3,5`
newDate=$(date -d "$Date" +%Y-%m-%d)
Time=`capinfos -Tra temp/$s | awk '{print $5}' | cut -d ":" -f1,2`
 
file="${ServerName}_${newDate}_${Time}.pcap"
 
 
mv temp/$s temp/${file}
#sshpass -p $pass scp temp/$file $username@$server_ip:$path_to_destination
 
echo "$file ... done"
 
sleep 5
 
rm temp/$file
 
done
 
 
done