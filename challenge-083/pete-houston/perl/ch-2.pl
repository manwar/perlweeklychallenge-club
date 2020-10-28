#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8302.pl
#
#        USAGE: ./8302.pl N ... 
#
#  DESCRIPTION: Flip the signs of some values of the array to get as
#               close as possible to 0 sum (but not negative).
#               Minimise for sum and then the number of sign flips.
#
# REQUIREMENTS: Params::Util, List::Util, Math::Combinatorics
#        NOTES: This is a bit brute-force; there is doubtless a neater
#               number-theory solution of which I am unaware.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/10/20
#===============================================================================

use strict;
use warnings;
use Params::Util '_POSINT';
use List::Util 'sum';
use Math::Combinatorics;

my @in = grep { _POSINT ($_) } @ARGV;
die "Only natural number, please\n" unless $#in == $#ARGV;

my $tot  = sum @in;  # Total of all positive numbers
my $min  = $tot;     # Start minimum sum 
my $minc = $#in;     # Start minimum number of negations

# Loop over half, checking absolute differences.
for my $count (1 .. int (($#in + 1) / 2)) {
	my $combi = Math::Combinatorics->new (
		count => $count,
		data  => [@in]
	);
	while (my @set = $combi->next_combination) {
		my $diff = $tot - 2 * sum @set;
		next unless abs $diff <= $min;
		my $numitems = $count;
		if ($diff < 0) {
			# It is the inverse of @set that we want
			# Invert diff and $numitems
			$diff *= -1;
			$numitems = @in - $count;
		}
		if ($diff == $min) {
			$minc = $numitems if $numitems < $minc;
			next;
		}
		print "New min $diff for @set\n";
		$min = $diff;
		$minc = $numitems;
	}
}

print "Mininum $minc signs flipped for lowest non-negative total of $min.\n";
