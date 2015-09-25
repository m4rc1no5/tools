#!/bin/bash

# ------------------------------------------------------------------------------------
# USE AT YOUR OWN RISK. Tested on Linux Mint 17.1 with nginx.
# CHECK COMMENTS BEFORE RUNNING
#
# This script creates localhost website folder and adds virtual domain with sufix .lh
# eg. "sudo ./addVirualHostNginx.sh test" will create test.lh local domain
#
# Before run this script please view config.sh and check variables!
# ------------------------------------------------------------------------------------

# read config file
source config.sh

# check if is set website variable
website="$@"
if [ -z "$website" ]; then
	echo "Please add website name - eg. test"
	echo " "
	exit
fi

# set paths
pathToWebsiteDirectory=${htdocs}${website}
pathToIndex="${htdocs}${website}/index.html"

# virtual host lines; check the logs paths!
virtHost="
server {
    listen   80; ## listen for ipv4; this line is default and implied
    #listen   [::]:80 default ipv6only=on; ## listen for ipv6

    root ${htdocs}${website};
    index index.html index.htm index.php;

    # Make site accessible from http://localhost/
    server_name ${website}.lh www.${website}.lh;

    error_log /var/log/nginx/${website}_error.log;
    access_log /var/log/nginx/${website}_access.log;
}"

# create directory
echo "Create directory ${pathToWebsiteDirectory}"
mkdir ${pathToWebsiteDirectory}

# make index.html
echo "Create index.html: ${pathToWebsiteDirectory}"
touch ${pathToIndex}

# change permissions and owner
echo "Change permissions (0775) and owner ${user}:${user} to ${pathToWebsiteDirectory}"
chmod -R 0775 ${pathToWebsiteDirectory}
chown ${user}:${user} ${pathToWebsiteDirectory}

# add hello world to index.html
echo "Add hello ${website}! to ${pathToIndex}"
echo "hello ${website}!" >> ${pathToIndex}

# add virtualhost
echo "Add virtalhost config to nginx sites-available and sites-enabled"
pathToWebsiteConf=${nginxSitesAvailablePath}${website}_lh.conf
touch ${pathToWebsiteConf}
echo "${virtHost}" >> ${pathToWebsiteConf}
ln -s ${pathToWebsiteConf} ${nginxSitesEnabledPath}${website}_lh.conf

# add host into hosts
echo "Add host into hosts file (${hostsPath})"
echo "127.0.0.1	${website}.lh" >> ${hostsPath}

# restart nginx
echo "Restart nginx"
service nginx restart