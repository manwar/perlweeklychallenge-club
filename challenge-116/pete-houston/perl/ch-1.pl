#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11601.pl
#
#        USAGE: ./11601.pl N 
#
#  DESCRIPTION: Can this number be split into a sequence of ascending
#               continguous smaller numbers?
#
#        NOTES: N must be a decimal integer of 2 digits or more
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/06/21
#===============================================================================

use strict;
use warnings;

my $n = shift;

my $halflen = length ($n) / 2;

for my $power (1 .. $halflen) {
	my $parts = my $target = my $x = substr ($n, 0, $power);
	do {
		$target .= ++$x;
		$parts  .= ',' . $x;
	} until $target >= $n;
	if ($target == $n) {
		print "$parts\n";
		exit;
	}
}

print "$n\n";
