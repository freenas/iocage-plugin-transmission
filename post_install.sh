#!/bin/sh
sysrc -f /etc/rc.conf transmission_enable="YES"
sysrc -f /etc/rc.conf transmission_download_dir="/usr/local/etc/transmission/home/Downloads"
# Start service once to create the files needed
service transmission start
sleep 2 # It can take a few seconds.

# Without the whitelist disabled, the user will not be able to access it. They can reenable and manually whitelist their IP's.
SETTINGS="/usr/local/etc/transmission/home/settings.json"

echo "Disabling RPC whitelist, you may want to reenable it with the specific IP's you will access transmission with by editing $SETTINGS"
sed -i '' -e 's/\([[:space:]]*"rpc-whitelist-enabled":[[:space:]]*\)true,/\1false,/' $SETTINGS

#Create a Download Directory
mkdir -p /usr/local/etc/transmission/home/Downloads
chmod 755 /usr/local/etc/transmission/home/Downloads

# Start the service
service transmission reload
