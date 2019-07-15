#! /bin/bash

username="entrada" #server username
server_ip=192.168.8.124    #server ip address
path_to_destination="~/Desktop" #destination address in the server
location=$1
pass="123123"
Delay=30



if ! [ -e 'line.log' ] 
then
echo 1 > line.log
fi



echo "======================================="
line=`head -n 1 line.log`



find $location -type f | awk -v line=$line '{if(NR>=line) print $0}' | 
while read -r i
do 
#split the file name and the path from total path $i
echo "I ::: $i"
FileName=`echo $i | cut -d / -f6`
Path=`echo $i | cut -d / -f 6 --complement`

#parse the file name
echo "FILENAME:::: $FileName"
ServerName=`echo $FileName | cut -d "." -f 1`
echo "SERVERNAME:::: $ServerName"
Date=`echo $FileName | cut -d "_" -f 2`
Hour=`echo $FileName | cut -d "_" -f 3`
Minute=`echo $FileName | cut -d "_" -f 4`
Time="${Hour}:${Minute}"

#construct the new name
file="${ServerName}_${Date}_${Time}.pcap"

#change the name
#mv $Path/$FileName $Path/$file
echo "new FILENAME:::: $file"
echo " "


#sshpass -p $pass scp $Path/$file $username@$server_ip:"$path_to_destination/$ServerName"
echo "$file ... done"



#sleep $Delay

echo "======================================="
line=$((line+1))

echo $line > line.log

done

echo "Thank you"


