#!/bin/bash

########################################################################
########################################################################
########################################################################

#########################
#                       #
#       nopen.sh        #
#                       #
#########################

#Version: 1.0.0
#Written by: omniptipus
#Initially Created: 2021-04-23
#Modified on:  

########################################################################
########################################################################
########################################################################

##Purpose of this script:
##
##

##Syntax: 
##
##Description:


##Additional features hopefully added in a future version
##
##


########################################################################
########################################################################
########################################################################

#######################################
#                                     #
#          USER CONFIGURATION         #
#                                     #
#######################################

# enable global debugging of script
## set to "on" to echo additional comments to screen
## set to "off" or simply comment out for production

ECHO_DEBUG=off













#######################################
#                                     #
#       END OF USER CONFIGURATION     #
#                                     #
#######################################


##Syntax conventions in effect:
# i am a comment i.e. comments are prefixed wih a number sign (#) and \
#will not print/run
#I_AM_A_VARIABLE = multi word variables are all caps with underscores
#function_i_am_a_function = function names are prefixed with the word \
#"function" and are all lowercase with underscores
#i-am-a-filename.txt = filenames are all lowercase and dashed

###########################
# Define Common Functions #
###########################

#----------------------------
ECHO_DEBUG ()
#----------------------------
{

# goal of function:
# this function checks for errors to aid in debugging
# will echo passed parameters only if ECHO_DEBUG is set to "on" in header of script
# yes, ECHO_DEBUG breaks our syntax conventions in favor of readability when debugging.
# i grow old, i grow old, i shall wear the bottoms of my trousers rolled . . ."
[ "$ECHO_DEBUG" = "on" ] &&  $@

}  # end of function ECHO_DEBUG

ECHO_DEBUG echo "DEBUG: PID equals $$"





###########################
# Define Common Variables #
###########################

#Date Variables
DATE_NOW=$(TZ=America/Los_Angeles date +"%Y-%m-%d_%T")
DATE_DAY=$(TZ=America/Los_Angeles date +"%Y-%m-%d")


#Script Name Variable
SCRIPT_NAME=$(basename $0)
PID=$$


##############
# Exit Codes #
##############

# Error 99, Script is not run as root
E_NOT_ROOT="99"

####################
# Script Functions #
####################


#----------------------------
function_blah ()
#----------------------------
{
#I am a function. Put things here
#Remember to add syntax clues

echo "function_blah"

}

#----------------------------
function_date_now ()
#----------------------------
{
#Set the "Now" date

DATE_NOW=$(TZ=America/Los_Angeles date +"%Y-%m-%d_%T")

}

#----------------------------
function_date_day ()
#----------------------------
{

#Date Variables
DATE_DAY=$(TZ=America/Los_Angeles date +"%Y-%m-%d")

}

#----------------------------
function_help ()
#----------------------------
{
echo ""
echo "Failed. Please follow the appropriate syntax."
echo ""

echo "The nopen command opens note files in your default text editor. It uses the path ~/Documents/Notes/ and assumes you have the date in YYYY_MM_DD format as the first part of the file name."
echo ""


echo "Arguments:"
echo "-y: Open yesterday"
echo "-w: open notes from the past 7 days"
echo "-m: open notes from the past 31 days"
echo "-d: Open a specific date or wildcard it. If -d is used, you must provide a date as an additional argument."
echo "-h: Show this help dialogue"
echo "WARNING: Multiple options may NOT be strung together (i.e. -yw will error out)."


echo ""
echo "Syntax"
echo "Example: nopen -d 2021-04-21 <- this will open the notes from this day, if they exist."
echo "Example: nopen -d 2021-04- <- this will open all notes from April 2021."
echo "Example: nopen -d *-04- <- If you want to be stupid, this will open all notes files from April of every year. If you remove the hyphens it will open any note from a date which includes 04. This is dumb, don't do it."

echo ""


echo ""
echo "NOTE: This script works best in conjunction with other scripts by omniptipus: notes.sh, nopen.sh, and Daily_Notes.command"
echo ""

}


####################
# Script Variables #
####################








##########################
#   SCRIPT BEGINS HERE   #
##########################
ECHO_DEBUG echo "DEBUG: Script begins here... "


if [ -z $1 ]; then
	echo "You must use an argument."
	function_help
	exit 99
fi

if [ $1 == '-h' ]; then
	function_help
	exit 0
fi


if [ $1 == '-d' ]; then
	if [ -z $2 ]; then
		function_help
		exit 98
	else
	NOTE_TO_OPEN="$2*.txt"
	ECHO_DEBUG echo "NOTE_TO_OPEN equals $NOTE_TO_OPEN"
	find ~/Documents/Notes -type f -name $NOTE_TO_OPEN -exec open {} \;
	exit 0
	fi
fi

if [ $1 == '-y' ]; then
	YESTERDAY=$(date -v -1d '+%Y-%m-%d')
	NOTE_TO_OPEN="$YESTERDAY*.txt"
	ECHO_DEBUG echo "NOTE_TO_OPEN equals $NOTE_TO_OPEN"
	find ~/Documents/Notes -type f -name $NOTE_TO_OPEN -exec open {} \;
	exit 0
fi


if [ $1 == '-w' ]; then
	ECHO_DEBUG echo "Primary argument is -w"
	DAY_RECURSIVE=1
	while [ $DAY_RECURSIVE -lt '8' ]; do
		DATE_TO_OPEN=$(date -v -"$DAY_RECURSIVE"d '+%Y-%m-%d')
		ECHO_DEBUG echo "DATE_TO_OPEN equals $DATE_TO_OPEN"
		NOTE_TO_OPEN="$DATE_TO_OPEN*.txt"
		ECHO_DEBUG echo "NOTE_TO_OPEN equals $NOTE_TO_OPEN"
		DAY_RECURSIVE=$((DAY_RECURSIVE+1))
		find ~/Documents/Notes -type f -name $NOTE_TO_OPEN -exec open {} \;
	done
	exit 0
fi

if [ $1 == '-m' ]; then
	ECHO_DEBUG echo "Primary argument is -w"
	DAY_RECURSIVE=1
	while [ $DAY_RECURSIVE -lt '31' ]; do
		DATE_TO_OPEN=$(date -v -"$DAY_RECURSIVE"d '+%Y-%m-%d')
		ECHO_DEBUG echo "DATE_TO_OPEN equals $DATE_TO_OPEN"
		NOTE_TO_OPEN="$DATE_TO_OPEN*.txt"
		ECHO_DEBUG echo "NOTE_TO_OPEN equals $NOTE_TO_OPEN"
		DAY_RECURSIVE=$((DAY_RECURSIVE+1))
		find ~/Documents/Notes -type f -name $NOTE_TO_OPEN -exec open {} \;
	done
	exit 0
fi

function_help
exit 97

ECHO_DEBUG echo "DEBUG: Script ends here... "
#####################
#   END OF SCRIPT   #
#####################
