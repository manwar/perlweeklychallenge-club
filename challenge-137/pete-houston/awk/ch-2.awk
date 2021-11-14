#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 13702.awk
#
#        USAGE: ./13702.pl
#
#  DESCRIPTION: Lychrel numbers on STDIN output 1, 0 otherwise.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/11/21
#===============================================================================

function reverse (str) {
	rev = ""
	for (j = length (str); j > 0; j--) {
		rev = rev substr (str, j, 1)
	}
	return rev
}

/^[1-9][0-9]{1,3}$/ {
	maxn    = 10000000
	maxiter = 500
	n       = $0
	for (i = 1; i < maxiter; i++) {
		revn = reverse(n)
		if (revn == n) {
			print "0"
			next
		}
		n += revn
		if (n > maxn) {
			print "1"
			next
		}
	}
	print "1"
	next
}
