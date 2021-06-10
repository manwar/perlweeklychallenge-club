#!/bin/bash
#===============================================================================
#
#         FILE: 10601.sh
#
#        USAGE: ./10601.sh < infile
#
#  DESCRIPTION: Output maximum difference between adjacent integers.
#               Input should be a set of integers separated by
#               whitespace (incl. newlines)
#
# REQUIREMENTS: Inputs must all be integers otherwise they will be
#               skipped
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 30/03/21
#===============================================================================

prev='z'
max=0

adjdiff () {
	if [ $prev != 'z' ]; then
		mydiff=$(($1 - $prev))
		if [ $mydiff -gt $max ]; then
			max=$mydiff
		fi
	fi
	prev=$1
}

sed -e 's/[ \t]/\n/g' | grep -E '^-?[0-9]+$' | sort -un | while read line
do
	adjdiff $line
	echo $max
done | tail -1
