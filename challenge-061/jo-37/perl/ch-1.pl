#!/usr/bin/perl

# the challange says: you are given a list of 4 or more numbers.
# It is not clear if these are integers.
# In this implementation integers are presumed.

use Test2::V0;
use bigint;

# this sub returns the maximum product of a contiguous sublist
# of the given list and the corresponding sublist
sub max_prod_sublist;
sub max_prod_sublist {
	my $list = shift;

	# empty lists don't count as any value is greater than nothing
	return (-inf(), $list) unless @$list;

	# return single element
	return ($list->[0], $list) if @$list == 1;

	# get the product, the index of the first zero and
	# every other index of negative values
	my $odd = 1;
	my ($prod, $null, @neg) = 1;
	for (my $i = 0; $i < @$list; $i++) {
		my $val = $list->[$i];
		$prod *= $val;
		$null //= $i unless $val;
		if ($val < 0) {
			push @neg, $i if $odd;
			$odd = !$odd;
		}
	}

	# If the product is positive, it is maximal.
	return ($prod, $list) if $prod > 0;

	# If the product is zero, the maximum product is either in the
	# left part, in the right part or it is zero
	# Recurse into the first two and return the max of all three.
	if ($prod == 0) {
		my ($pl, $ll) = max_prod_sublist [@{$list}[0 .. $null - 1]];
		my ($pr, $lr) = max_prod_sublist [@{$list}[$null + 1 .. $#$list]];
		if ($pl > 0 || $pr > 0) {
			return $pl > $pr ? ($pl, $ll) : ($pr, $lr);
		} else {
			return (0, [0]);
		}
	}

	# If the product is negative, then there is an odd number of
	# negative values in the list.
	# The maximum product must be in a sublist that has an even number
	# of negative elements.  Such a sublist must be the left or right
	# part from every other negative value
	# Recurse into all these parts and return the max.
	
	my ($pmax, $lmax) = -inf();
	foreach my $i (@neg) {
		my ($pl, $ll) = max_prod_sublist [@{$list}[0 .. $i - 1]];
		my ($pr, $lr) = max_prod_sublist [@{$list}[$i + 1 .. $#$list]];

		if ($pl > $pmax) {
			$pmax = $pl;
			$lmax = $ll;
		} elsif ($pr > $pmax) {
			$pmax = $pr;
			$lmax = $lr;
		}
	}
	return ($pmax, $lmax);
}

# main
my ($p, $l);

($p, $l) = max_prod_sublist([2, 5, -1, 3]);
is $p, 10, 'prod from challenge';
is $l, [2, 5], 'list from challenge';

($p, $l) = max_prod_sublist([-1, 0, 3, 0, 2, 4, -1, 3, -1, 2, -1, 3, 0]);
is $p, 48, 'an example: max prod';
is $l, [2, 4, -1, 3, -1, 2], 'an example: list';

($p, $l) = max_prod_sublist([]);
is $p, -inf(), 'empty list\'s prod';
is $l, [], 'empty list';

($p, $l) = max_prod_sublist([-1, 0]);
is $p, 0, 'right zero is max';
is $l, [0], 'zero';

($p, $l) = max_prod_sublist([0, -1]);
is $p, 0, 'left zero is max';
is $l, [0], 'zero';

($p, $l) = max_prod_sublist([-1, 0, -1]);
is $p, 0, 'middle zero is max';
is $l, [0], 'zero';

done_testing
