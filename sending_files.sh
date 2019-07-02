#! /bin/bash
file_names=('hello.sh' 'test.sh') #array holds file names of all files to be sent...include extension with file name
username="root" #server username
server_ip=94.237.80.39 #server ip address
path_to_destination="/root/testing" #destination address in the server
scp -o ConnectTimeout=20 ${file_names[@]} $username@$server_ip:$path_to_destination || echo "Could not establish connection with given IP, ensure correct IP is supplied."
