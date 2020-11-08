#!/bin/bash
#*************************************************************************************
# script name: testCompilation
# Description: compile a .c file with gcc and save all output from gcc to a log file
# Parameters: 1st parameter: name of log file (created by the script)
#			  2nd parameter: name of the program that we want to compile (and link) (without prefix .c)
# Return value: 1 if there are errors or warnings
#               0 if the compile was successful
#*************************************************************************************

gcc -g -Wall -o "$2" "$2".c> "$1" 2>> "$1"		#compile and link the program with name (parameter 2), write the output to log file (parameter 1), and append errors 
if grep -e error -e warning "$1" > /dev/null; then	# if warnings or errors were found
	echo "Compile failed"
	exit 1
else
	echo "Compile succeeded"
	exit 0
fi

