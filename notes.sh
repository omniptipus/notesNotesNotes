#!/bin/bash

########################################################################
########################################################################
########################################################################

#########################
#                       #
#        notes.sh       #
#                       #
#########################

#Version: 1.0.0
#Written by: omniptipus
#Initially Created: 2020-04-23
#Modified on:  2020-06-02

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

echo "The notes command uses grep to search for a text string in every file within the ~/Documents/Notes directory. This is case insensitive"
echo "Example: notes 'Fortigate' <-- gives the same result as"
echo "Example: notes 'fortigate'."
echo ""

echo "**IT IS STRONGLY RECOMMENDED THAT YOU ALWAYS USE SINGLE QUOTES TO ENCASE YOUR SEARCH STRINGS**"
echo "**FAILURE TO DO SO WILL CAUSE ERRATIC RESULTS**"

echo "If you include punctuation, you must escape it using the \ character even if it's within single quotes."

echo ""
echo "Options:"
echo "-o : Add this option to the end of your command to open all files where the string is matched. Best to use this after checking how many results are returned."
echo "-l: List file names where the string is found, but not the actual string or contents of the file."
echo "WARNING: Multiple options may NOT be strung together (i.e. -ol will error out)."
echo ""

echo "Syntax:"
echo "Use: notes 'string' -option"
echo "Example: notes 'fortigate' <- This will search your notes for the string 'fortigate' and output the path of any file which contains the string to standard out."



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




if [[ -z $1 ]]; then
	echo "You must use an argument."
	function_help
	ECHO_DEBUG echo "Error 99"
	exit 99
fi

if [[ -z $2 ]]; then
	ECHO_DEBUG echo "DEBUG: Second argument empty, using first argument as search string."
	grep -iR "$1" ~/Documents/Notes
	ECHO_DEBUG echo "DEBUG: Exiting successful"
	exit 0
fi

if [[ $1 == '-o' ]]; then
	ECHO_DEBUG echo "DEBUG: Open option has been selected"
	grep -iRl "$2" ~/Documents/Notes | xargs open
	ECHO_DEBUG echo "DEBUG: Exiting successful"
	exit 0
fi

if [[ $1 == '-l' ]]; then
	ECHO_DEBUG echo "DEBUG: List option has been selected"
	grep -iRl "$2" ~/Documents/Notes
	ECHO_DEBUG echo "DEBUG: Exiting successful"
	exit 0
fi


ECHO_DEBUG echo "DEBUG: NO CRITERIA MET. EXITING 97"
function_help
exit 97




ECHO_DEBUG echo "DEBUG: Script ends here... "
#####################
#   END OF SCRIPT   #
#####################
