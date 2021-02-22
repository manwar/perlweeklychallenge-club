#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9802.pl
#
#        USAGE: ./9802.pl ITEM N [ N ... ] 
#
#  DESCRIPTION: Find or insert ITEM into list of ascending N
#
#        NOTES: Assumes all inputs are integers and the list is sorted
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 01/02/21
#===============================================================================

use strict;
use warnings;

my ($new, @n) = @ARGV;

my $pos = find_or_insert ($new, \@n);
print "$new is at index $pos\nArray is now @n\n";

sub find_or_insert {
	my ($new, $n) = @_;

	# Is it outside the range?
	if ($new < $n->[0]) {
		unshift @$n, $new;
		return 0;
	}
	if ($new > $n->[-1]) {
		push @$n, $new;
		return $#$n;
	}

	# Initial boundaries
	my $low = 0;
	my $high = $#$n;

	# Loop until the boundaries touch
	while ($high - $low > 1) {
		for ($low, $high) {
			return $_ if $n->[$_] == $new;
		}

		# Somewhere in between so apply binary search
		my $target = $low + int (($high - $low) / 2);
		return $target if $n->[$target] == $new;

		if ($new < $n->[$target]) {
			$high = $target;
		} else {
			$low = $target;
		}
	}

	# Not in the list, so insert it.
	splice @$n, $high, 0, $new;
	return $high;
}
