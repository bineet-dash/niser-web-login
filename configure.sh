#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' unzip 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get install unzip;
fi

if [ $(dpkg-query -W -f='${Status}' xvfb 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get install xvfb;
fi

mkdir assets
wget -O chromedriver_pkg.zip https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux32.zip
unzip chromedriver_pkg.zip -d assets/ && rm -rf chromedriver_pkg.zip

if [ $(dpkg-query -W -f='${Status}' python2.7 2>/dev/null | grep -c "ok installed") -eq 0 ] || [ $(dpkg-query -W -f='${Status}' python3 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install python2.7;
else
  echo "Package installed";
fi

sudo apt-get install python-pip;
sudo pip install selenium; 
sudo pip install xvfbwrapper;

echo "----------------------------------"
echo 
echo 

read -p "Enter your NISER username : " username
read -s -p "Enter your NISER password : " password
echo 

sed -i -e "s/\(uname=\).*/\1'$username'/" \
-e "s/\(passwd=\).*/\1'$password'/"  niser_web_login

sudo mkdir -p /usr/local/src/niserauth
sudo cp -R assets /usr/local/src/niserauth/
sudo cp niser_web_login /usr/local/bin

echo "---------------------------------"
echo
echo
echo "Now connect to NISER WiFi, and you can automatically login by running the command 'niser_web_login' from your terminal." 
