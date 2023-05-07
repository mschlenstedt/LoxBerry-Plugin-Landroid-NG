#!/bin/bash

# Vars
repo="https://github.com/mschlenstedt/mqtt-landroid-bridge.git"
pluginname=$(perl -e 'use LoxBerry::System; print $lbpplugindir; exit;');
oldversion=$(jq -r '.version' $LBPDATA/$pluginname/mqtt-landroid-bridge/package.json)

# Logging
. $LBHOMEDIR/libs/bashlib/loxberry_log.sh
PACKAGE=$pluginname
NAME=upgrade
LOGDIR=${LBPLOG}/${PACKAGE}
STDERR=1
LOGSTART "Landroid-NG upgrade started."

# Clone Repo
LOGINF "Cloning $repo..."
rm -rf $LBPDATA/$pluginname/mqtt-landroid-bridge
git clone $repo $LBPDATA/$pluginname/mqtt-landroid-bridge 2>&1 | tee -a $FILENAME

# Symlink config
LOGINF "Symlinking config file..."
rm $LBPDATA/$pluginname/mqtt-landroid-bridge/config.json
ln -sv $LBPCONFIG/$pluginname/config.json $LBPDATA/$pluginname/mqtt-landroid-bridge/config.json 2>&1 | tee -a $FILENAME

# Install
LOGINF "Installing..."
cd $LBPDATA/$pluginname/mqtt-landroid-bridge
npm install 2>&1 | tee -a $FILENAME

# End
newversion=$(jq -r '.version' $LBPDATA/$pluginname/mqtt-landroid-bridge/package.json)
LOGOK "Upgrading Bridge from $oldversion to $newversion"
LOGEND "Upgrading Bridge from $oldversion to $newversion"
exit 0
