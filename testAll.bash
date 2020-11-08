#!/bin/bash
#*************************************************************************************
# script name: testAll
#
# Description: Receives a list of tests with the format:
#              <testDescription>@<programName>@<inputFile>@<outputFile>
#              Checks if a folder named logFiles exists: exits with an error
#              with so, and creates the folder and continues otherwise
#              Performs the tests. Prints out the total number of tests run 
#              and the number of tests passed. Writes the results to indivdual 
#              log files at /logFiles which are sorted by test number.
#
# Parameters:  1st parameter: a list of tests with the format:
#              <testDescription>@<programName>@<inputFile>@<outputFile>
#
# Return value: 1 if the folder logFiles already exists
#               0 if the script completed successfully
#*************************************************************************************

if [ -d logFiles ]
then
	echo "Error! Log file already exists. Exiting..."
	exit 1
fi

mkdir logFiles

(( lineNum=0 ))
(( numTests=0 ))
(( numSuccessfulTests=0 ))

#set word delimiter to '@', and read the 4 parameters from each line
#parantheses on the 'while' so that initial variables (lineNum, numTests, etc) are updated 
#within the subshell of read and not overwritten at the end 
cat "$1" | ( while IFS='@' read -r testDescript progName inFile outFile
do
	if [ ! -z "$testDescript" ]		#if the first field of the line is not empty
	then
		(( ++lineNum ))
		echo ${lineNum}:" ""$testDescript"		#prints line number and test description
		if testCompilation logFiles/${lineNum}.compile.log "$progName"
		then
			(( ++numSuccessfulTests ))
		fi
		(( ++numTests ))
		if testInOut logFiles/${lineNum}.inout.log "$progName" "$inFile" "$outFile"
		then
			(( ++numSuccessfulTests ))
		fi
		(( ++numTests ))
		if testMemLeaks logFiles/${lineNum}.memory.log "$progName" "$inFile"
		then
			(( ++numSuccessfulTests ))
		fi
		(( ++numTests ))
	fi
done
echo "Total tests: ${numTests}"
echo "Tests passed: ${numSuccessfulTests}" )

exit 0