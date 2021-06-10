#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10401.pl
#
#        USAGE: ./10401.pl [ N ]
#
#  DESCRIPTION: Output first N (or 50) FUSC numbers
#               There are 2 algorithms here and it outputs both results
#               to show they give the same answers
#
#      OPTIONS: If N is not provided, defaults to 50
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/03/21
#===============================================================================

use strict;
use warnings;

my $target = $ARGV[0] ? $ARGV[0] - 1 : 49;

my @stock = standard_fusc ($target);
print "stock: @stock\n";
my @ahead = look_ahead ($target);
print "ahead: @ahead\n";

# This implements the algorithm exactly as specified in the the
# challenge
sub standard_fusc {
	my $max = shift;
	my @fusc = (0, 1);
	for my $n (2 .. $max) {
		push @fusc, $n % 2 ?
			$fusc[($n - 1) / 2] + $fusc[($n + 1) / 2] :
			$fusc[$n / 2];
	}
	return @fusc;
}

# This should be a more efficient algorithm
sub look_ahead {
	my $max = shift;
	my @fusc = (0, 1);
	for my $n (1 .. $max / 2) {
		push @fusc, $fusc[$n];
		push @fusc, $fusc[$n] + $fusc[$n + 1];
	}
	pop @fusc unless $max % 2;
	return @fusc;
}
