#!/bin/bash
#*************************************************************************************
# script name: testMemLeaks
# Description: Runs valgrind on a program. Passes an input file to the standard input,
#              and checks for memory leaks and illegal memory accesses
# Parameters: 1st parameter: name of log file (created by the script)
#			  2nd parameter: name of the program that we want to test
#			  3rd parameter: name of the input file
# Return value: 1 if the memory test failed
#               0 if the memory test was successful
#*************************************************************************************

valgrind --tool=memcheck ./"$2"<"$3">/dev/null 2>"$1" 

if grep "ERROR SUMMARY: 0 errors" "$1">/dev/null		#if there are 0 errors, then the test is passed
then
	echo "Memory test passed"
	exit 0
else
	echo "Memory test failed"
	exit 1
fi