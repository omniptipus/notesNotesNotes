#!/bin/bash


#Created by Trevor for Trevor
#1/26/2016
#Execute this script to create a text file in ~/Documents/Notes with today's Date in the filename


#NOTE: This script works best in conjunction with other scripts by tsys: notes.sh, nopen.sh, and Daily_Notes.command"

#NOTE: Work's best if Terminal is set to close after a process completes


#Name of user executing the script
USER_NAME=$(whoami)


#Today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

#Directory to save the file - include trailing slash
SAVEDIR=$"/Users/"$USER_NAME"/Documents/Notes/"

#Full filepath with filename and date
FULLPATH=$"$SAVEDIR""$TODAY"_"Notes.txt"
####

if [ -f "$FULLPATH" ] ; then
	echo "Todays notes already exist. Opening in default text editor."
	open "$FULLPATH"
else
	echo "No notes exist today. Creating a new note file and opening in default text editor."
	touch "$FULLPATH"
	echo "$TODAY" >> $FULLPATH
	echo "---" >> $FULLPATH
	echo "" >> $FULLPATH
	open "$FULLPATH"
fi


exit