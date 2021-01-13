#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 7201.awk
#
#  DESCRIPTION: Given a whole number N display the number of trailing
#               zeros in N!
#
#        NOTES: The task was up to N = 10 but this works up to 22 on a
#               64-bit platform. Tested on gawk but should work on most
#               awks.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/08/20
#===============================================================================
BEGIN { print "Enter a whole number on each line." }
!/^[0-9]+$/ { print "Input is not a whole number - skipping"; next; }
$1 > 22 { print "Too big for integer type - skipping"; next; }
{
	f = x = $1;
	while (x > 2) {
		x--;
		f = f * x;
	}
	print "Factorial is " f;
	match (f, /0*$/);
	print "Trailing zeros: " RLENGTH;
}
