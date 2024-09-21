#!/bin/bash
####### Start Variables Definition ####### 
USERNAME=$1
dirName="NewDir"
tarfile=$dirName.tar
####### Start Colors Definition ####### 
redcolor=`tput setaf 1`
greencolor=`tput setaf 2`
reset=`tput sgr0`
bold=`tput bold`


# Error Checking for non empty input to script

if [ -z "$USERNAME" ]; then
	echo "${redcolor}ERROR !!"
	echo "Username field is empty ,please input a proper Username"
	echo "${reset}Exit Status 1"
	exit 1
else
	echo "Username provided = ${greencolor}${bold}$USERNAME ${reset}"
fi
# Error Checking for valid username 

if ! id "$USERNAME" &>/dev/null; then
    echo "${redcolor}ERROR !!"
    echo "Username not found"
    echo "${reset}Exit Status 2"
    exit 2
fi

# Error Checking for username directory if it exists

if [ ! -d "/home/$USERNAME" ]; then
	echo "${redcolor}ERROR !!"
	echo "Username Home Directory not found"
	echo "${reset}Exit Status 3"
	exit 3
else
	echo "Username Directory= ${greencolor}${bold}/home/$USERNAME ${reset}"
fi



#	Check if the directory we want to create already exists,
# 	and if it does, remove it.

echo "/// Checking Directory"
sleep 2

if [ -d "$dirName" ]; then ## If -d FILE exists and is a directory
	echo "/// Directory Found , Deleting ..."
	sleep 2
	# Remove Directory
	rm -rf $dirName 
else
	echo "/// No Folder Exists"
	sleep 2
fi

# Create the directory & create 4 files in this directory 
#(main.c, main.h, hello.c, hello.h)

echo "${greencolor}${bold}Making Directory and Files ${reset} "
echo "-----------------------------------"
sleep 2

mkdir $dirName && touch $dirName/main{.c,.h} $dirName/hello{.c,.h}
cd $dirName
for i in *; do
  	echo "This File is named $i" > "$i"
done
cd ..

echo "${greencolor}${bold}Compressing TAR${reset} "
echo "-----------------------------------"
sleep 2
tar -cf $tarfile $dirName

echo "${greencolor}${bold}Obtaining Permissions to User Home Dir${reset} "
echo "-----------------------------------"
sleep 2

sudo chmod -R o+rwx /home/"$USERNAME"
if [ $? -ne 0 ]; then
    echo "${redcolor}ERROR !!"
    echo "Failed to change permissions"
    echo "${reset}Exit Status 4"
    exit 4
fi


echo "${greencolor}${bold}Copy & Extracting TAR ${reset} "
echo "-----------------------------------"
sleep 2
cp $tarfile /home/$USERNAME && cd /home/$USERNAME && tar -xf $tarfile 


