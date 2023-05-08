#!/bin/bash
 
# You can use all vars from /etc/environment in this script.
#
# We add 5 additional arguments when executing this script:
# command <TEMPFOLDER> <NAME> <FOLDER> <VERSION> <BASEFOLDER>
#
# For logging, print to STDOUT. You can use the following tags for showing
# different colorized information during plugin installation:
#
# <OK> This was ok!"
# <INFO> This is just for your information."
# <WARNING> This is a warning!"
# <ERROR> This is an error!"
# <FAIL> This is a fail!"
 
# To use important variables from command line use the following code:
COMMAND=$0    # Zero argument is shell command
PTEMPDIR=$1   # First argument is temp folder during install
PSHNAME=$2    # Second argument is Plugin-Name for scipts etc.
PDIR=$3       # Third argument is Plugin installation folder
PVERSION=$4   # Forth argument is Plugin version
#LBHOMEDIR=$5 # Comes from /etc/environment now. Fifth argument is
              # Base folder of LoxBerry
PTEMPPATH=$6  # Sixth argument is full temp path during install (see also $1)
 
# Combine them with /etc/environment
PHTMLAUTH=$LBPHTMLAUTH/$PDIR
PHTML=$LBPHTML/$PDIR
PTEMPL=$LBPTEMPL/$PDIR
PDATA=$LBPDATA/$PDIR
PLOG=$LBPLOG/$PDIR # Note! This is stored on a Ramdisk now!
PCONFIG=$LBPCONFIG/$PDIR
PSBIN=$LBPSBIN/$PDIR
PBIN=$LBPBIN/$PDIR
 
echo "<INFO> Checking installed NodeJS Version..."

nodevermain=$(node -v | cut -d. -f1 | tr -d "v")
nodeverfull=$(node -v)

if [[ $nodevermain < 15 ]]; then
	echo "<INFO> Current NodeJS Version is: $nodeverfull - Upgrade needed."
	curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
else
	echo "<OK> Current NodeJS Version is: $nodeverfull - this is fine for me."
fi

# Exit with Status 0
exit 0
