#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15702.pl
#
#        USAGE: ./15702.pl N 
#
#  DESCRIPTION: Output 1 if N is a Brazilian number, 0 otherwise
#
# REQUIREMENTS: Math::NumberBase
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/03/22
#===============================================================================

use strict;
use warnings;

use Math::NumberBase;

my $n = shift;

# Validate
die "Bad argument - must be integer > 3\n" 
	unless defined ($n) && $n > 3 && $n =~ /^[0-9]+$/;

for my $base (2 .. $n - 2) {
	# Calculate n in this base
	my $conv = Math::NumberBase->new ($base);
	my $x = $conv->from_decimal ($n);
	# Are all the digits in the number the same?
	exit ! print "1\n" if same_digits ($x);
}

print "0\n";

sub same_digits {
	my $str = shift;
	my $first = substr $str, 0, 1;
	for my $pos (1 .. length ($str) - 1) {
		return 0 unless $first eq substr $str, $pos, 1;
	}
	return 1;
}
