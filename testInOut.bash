#!/bin/bash
#*************************************************************************************
# script name: testInOut
# Description: runs a program with a given name and passes to its standard input test input. Checks whether
#              the output of the program matches desired output.
# Parameters: 1st parameter: name of log file (created by the script)
#			  2nd parameter: name of the program that we want to check
#             3rd parameter: name of input file
#             4th parameter: name of desired output
# Return value: 1 if the output files are not identical
#               0 if the output files are identical
#*************************************************************************************
"$2" < "$3" > "$1" 				#redirects the input file ($3) to the program that we are testing (2) and then redirects the output to the log file ($1)
if diff "$1" "$4" > /dev/null 	#if the output files are identical
then
	echo "Out files match"
	exit 0
else
	echo "Out files mismatch"
	exit 1
fi