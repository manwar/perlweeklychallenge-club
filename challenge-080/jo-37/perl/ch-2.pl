#!/usr/bin/perl

use Test2::V0;
use List::Util qw(max sum);
use Data::Dump;

my $verbose = 1;

# Distribution of candies amongst candidates.
# The task's description together with its examples look somehow
# obscure.  Tried to implement something reasonable.
sub candies {

	# Initially all candidates get one candy.
	my @candies = (1) x @_;

	# Forward: If the candidate has a higher ranking than her left
	# neighbor, she gets one more candy than he.
	foreach (1 .. $#_) {
		$candies[$_] = $candies[$_ - 1] + 1
			if $_[$_] > $_[$_ - 1];
	}

	# Backward: If the candidate has a higher ranking than his right
	# neighbor, he gets at least one more candy than she.
	# The usage of negative subscrips might be confusing but achieves
	# symmetry to the forward block.
	foreach (2 .. @_) {
		$candies[-$_] = max $candies[-$_], $candies[-$_ + 1] + 1
			if $_[-$_] > $_[-$_ + 1];
	}

	# The number of candies alone does not provide much insight.
	if ($verbose) {
		dd @_;
		dd @candies;
	}

	sum @candies;
}

is candies(1, 2, 2), 4, 'first example';
is candies(1, 4, 3, 2), 7, 'second example';
is candies(1), 1, 'the lonely candidate';
is candies(1, 2, 3, 4, 1), 11, 'step up';
is candies(1, 4, 3, 2, 1), 11, 'step down';
is candies(1, 2, 3, 4, 3, 2), 13, 'right peak';
is candies(2, 3, 4, 3, 2, 1), 13, 'left peak';
is candies(1, 2, 3, 3, 3, 2, 1), 13, 'the unlucky fellow';

done_testing;
