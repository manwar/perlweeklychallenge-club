#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 15001.awk
#
#        USAGE: echo A B | ./15001.awk
#
#  DESCRIPTION: Output "Fibonacci strings" starting with A and B
#               and the 51st char of the first string to have that many
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 31/01/22
#===============================================================================

BEGIN {
	offset = 51;
}
{
	a = $1
	b = $2
	if (length (a) != length (b)) {
		print a " and " b " have different lengths. Skipping."
		next;
	}
	c = ""
	while (offset > length (c)) {
		c = a b
		a = b
		b = c
		print c
	}

	printf "Char at position %i is %s\n",
		offset,
		substr (c, offset, 1);
}
