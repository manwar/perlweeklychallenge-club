#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(shuffle);

# map3 is some kind of mixture and extension of map and reduce:
# It iterates over the elements of a list calling a code block,
# locally setting
# - $a to the previous element
# - $_ to the current element
# - $b to the next element
# and returning the the results of each invocation of the code block.
# The block is never called with $_ set to the first or last element
# of the list.
sub map3 (&@) {
	my $code = shift;

	my ($prev, $current, $next, $i);
	map {
		($prev, $current, $next) = ($current, $next, $_);
		++$i > 2 ?
			do {local ($a, $_, $b) = ($prev, $current, $next); $code->()} :
			();
	} @_;
}

my $N = 10;
local $" = ', ';

# Shuffle the deck and take the first N cards.
my @rand = splice @{[shuffle 1 .. 50]}, 0, $N;
print "Array: [@rand]\n";

# Add zeroes around the array to detect "border peaks".
print "Peak: [@{[map3 {$_ > $a && $_ > $b ? $_ : ()} 0, @rand, 0]}]\n";
