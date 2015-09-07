#!/bin/bash

# ------------------------------------------------------------------------------------
# USE AT YOUR OWN RISK. Tested on Linux Mint 17.1 with apache2.
# CHECK COMMENTS BEFORE RUNNING
#
# This script creates localhost website folder and adds virtual domain with sufix .lh
# eg. "sudo ./addLocalHost.sh test" will create test.lh local domain
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
<VirtualHost *:80>
    ServerAdmin ${user_mail}
    ServerName ${website}.lh
    ServerAlias *.${website}.lh
    DocumentRoot ${htdocs}${website}
    ErrorLog /var/log/apache2/${website}_error.log
    CustomLog /var/log/apache2/${website}_access.log combined
    <Directory ${htdocs}${website}>
        # enable the .htaccess rewrites
        AllowOverride All
        Allow from All
        Require all granted
    </Directory>
</VirtualHost>"

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
echo "Add virtalhost config to apache sites-available and sites-enabled"
pathToWebsiteConf=${apacheSitesAvailablePath}${website}_lh.conf
touch ${pathToWebsiteConf}
echo "${virtHost}" >> ${pathToWebsiteConf}
ln -s ${pathToWebsiteConf} ${apacheSitesEnabledPath}${website}_lh.conf

# add host into hosts
echo "Add host into hosts file (${hostsPath})"
echo "127.0.0.1	${website}.lh" >> ${hostsPath}

# restart apache
echo "Restart apache2"
service apache2 restart