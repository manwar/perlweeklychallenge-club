#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 10601.awk
#
#        USAGE: ./10601.awk < infile
#
#  DESCRIPTION: Output maximum difference between adjacent integers.
#               Input should be a set of integers separated by
#               whitespace (incl. newlines)
#
# REQUIREMENTS: Inputs must all be integers otherwise they will be
#               skipped
#        NOTES: Tested on gawk 4.1.1
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 30/03/21
#===============================================================================

{
	for (i = 1; i <= NF; i++) {
		k = NR "." i
		if (1 == match ($i, /-?[0-9]+/)) {
			ints[k] = $i
		}
	}
}
END {
	asort (ints, s, "@val_num_asc")
	max = 0
	last = "z"
	for (n in s) {
		if (last != "z") {
			diff = s[n] - last
			if (diff > max) { max = diff }
		}
		last = s[n]
	}	
	print "\n" max
}
