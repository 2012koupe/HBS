#!/bin/bash

##Came From COL

##Works VERY Well!

##Must be ran as root

# This is going to backup our hosts file.
if [ ! -f ~/hostsbackup ]
then
cp /etc/hosts ~/hostsbackup
fi

# Temp directory stuff.
Selfdestructinghosts=$(mktemp)
Selfdestructinghosts2=$(mktemp)

# Get some blocker lists and add to our existing /etc/hosts file.
wget -r -O - https://raw.githubusercontent.com/disconnectme/disconnect/b27abbf033c6f80f157fe9d98cb767c87065fbf4/firefox/content/disconnect.safariextension/opera/chrome/scripts/data.js >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/easylist.txt >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/easyprivacy.txt >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/antiadblockfilters.txt >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/fanboy-social.txt >> $Selfdestructinghosts

wget -r -O - http://winhelp2002.mvps.org/hosts.txt >> $Selfdestructinghosts

wget -r -O - http://hosts-file.net/ad_servers.asp >> $Selfdestructinghosts

wget -r -O - http://someonewhocares.org/hosts/hosts >> $Selfdestructinghosts

wget -r -O - https://easylist-downloads.adblockplus.org/malwaredomains_full.txt >> $Selfdestructinghosts

sed -e 's/\r//' -e '/^0.0.0.0/!d' -e '/localhost/d' -e 's/0.0.0.0/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < $Selfdestructinghosts | sort -u > $Selfdestructinghosts2

#Create a master hosts file.
echo -e "\n#Hostslist created "$(date) | cat ~/hostsbackup - $Selfdestructinghosts2 > ~/newblocklist

# Cleaning.
rm -rf $Selfdestructinghosts $Selfdestructinghosts2

# Replace current /etc/hosts with our new one.
cp ~/newblocklist /etc/hosts
