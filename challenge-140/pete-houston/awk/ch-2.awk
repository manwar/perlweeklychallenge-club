#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 14002.awk
#
#        USAGE: ./14002.awk [ INFILE ]
#
#  DESCRIPTION: Print the Kth element of the sorted multiplication table
#               of I and J. Provide input of J, J and K on each line of
#               INFILE or STDIN.
#
# REQUIREMENTS: Requires asort which is a gawkism so standard awk will
#               likely not work.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/11/21
#===============================================================================

{
	n = 0
	for (x = 1; x <= $1; x++) {
		for (y = 1; y <= $2; y++) {
			prods[n++] = x * y
		}
	}
	asort (prods)
	print prods[$3]
	delete prods
}
