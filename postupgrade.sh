#!/bin/bash

ARGV0=$0 # Zero argument is shell command
ARGV1=$1 # First argument is temp folder during install
ARGV2=$2 # Second argument is Plugin-Name for scipts etc.
ARGV3=$3 # Third argument is Plugin installation folder
ARGV4=$4 # Forth argument is Plugin version
ARGV5=$5 # Fifth argument is Base folder of LoxBerry

echo "<INFO> Copy back existing config files"
cp -p -v -r /tmp/$ARGV1\_upgrade/config/$ARGV3/* $ARGV5/config/plugins/$ARGV3/ 

#echo "<INFO> Copy back existing log files"
#cp -p -v -r /tmp/$ARGV1\_upgrade/log/$ARGV3/* $ARGV5/log/plugins/$ARGV3/ 

echo "<INFO> Remove temporary folders"
rm -r /tmp/$ARGV1\_upgrade

echo "Update config: we now need mqtt->topic from Version 0.6.1 on"
topic=$(jq -r '.mqtt.topic' $ARGV5/config/plugins/$ARGV3/config.json)

if [ "$topic" = "null" ]; then
	oldtopic=$(jq -r '.mower[0].topic' $ARGV5/config/plugins/$ARGV3/config.json)
	jq --arg oldtopic ${oldtopic} '.mqtt.topic = $oldtopic' $ARGV5/config/plugins/$ARGV3/config.json > $ARGV5/config/plugins/$ARGV3/config.json.new
	mv $ARGV5/config/plugins/$ARGV3/config.json.new $ARGV5/config/plugins/$ARGV3/config.json
fi


# Exit with Status 0
exit 0
