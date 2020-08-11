#!/usr/bin/perl
#
# Challenge 2: "Formatted Multiplication Table
# 
# Write a script to print 11x11 multiplication table, the top half triangle.
# 
#   x|   1   2   3   4   5   6   7   8   9  10  11
# ---+--------------------------------------------
#   1|   1   2   3   4   5   6   7   8   9  10  11
#   2|       4   6   8  10  12  14  16  18  20  22
#   3|           9  12  15  18  21  24  27  30  33
#   4|              16  20  24  28  32  36  40  44
#   5|                  25  30  35  40  45  50  55
#   6|                      36  42  48  54  60  66
#   7|                          49  56  63  70  77
#   8|                              64  72  80  88
#   9|                                  81  90  99
#  10|                                     100 110
#  11|                                         121
# "
# 
# My notes: trivial.
#

use v5.10;	# for "say"
use strict;
use warnings;

sub line
{
	my( $label, $gap, $scale ) = @_;
	printf "%4s|", $label;
	printf "%4s", '' for 1..$gap;
	printf "%4d", $_*$scale for $gap+1..11;
	print "\n";
}

line( "x", 0, 1 );
say '-' x 49;
for( 1..11 )
{
	line( $_, $_-1, $_ );
}
