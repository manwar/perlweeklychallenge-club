#!/usr/bin/perl

use Test2::V0;

# Valid n-tuples: the element at position k+1 must be larger than the
# element at position k.

# Select all numbers from $from to $to - $length + 1 and append all
# ($length - 1)-tuples starting with a larger number.
# $from is needed for recursion only
sub ascend;
sub ascend {
	my ($to, $length, $from) = @_;
	$from //= 1;

	return if $to - $from + 1 < $length || $from > $to || $length < 1;

	[map {my $i = $_;
		$length == 1 ? [$i] :
		map [$i, @$_], @{ascend $to, $length - 1, $i + 1}
	} ($from .. $to - $length + 1)];
}

is ascend(5, 1), [[1], [2], [3], [4], [5]], 'length 1';
is ascend(5, 2),
[[1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5]],
'old example from challenge';
is ascend(4, 3), [[1,2,3],[1,2,4],[1,3,4],[2,3,4]], 'length 3';
is ascend(3, 4), U(), 'length too large';
is ascend(3, 0), U(), 'length too small';
is ascend(3, 1, 4), U(), 'from too large';

done_testing;
