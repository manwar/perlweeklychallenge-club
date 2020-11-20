#!/usr/bin/perl

use Test2::V0;
use List::Util qw(reduce uniqnum);

# Find longest consecutive sequence in a list of integers.  An empty
# result in boolean context gives zero as requested.
sub lcs {
	# Sort unique values.
	my @sorted = uniqnum sort {$a <=> $b} @_;

	# Abusing "reduce" as a sliding window implementation for two
	# elements at a time.
	# Transform the sorted list into sawtooth shape, where every number
	# is shifted to zero if is not the successor of the previous.
	my @sawtooth;
	my $level;
	reduce {
			$level = $b if $b != $a + 1;
			push @sawtooth, $b - $level;
			$b
		} '-inf', @sorted;
	
	# Find the maximum and simultanously its position in the list.
	my $maxat = reduce {
			$sawtooth[$b] > $a->[0] ? [$sawtooth[$b], $b] : $a
		} ['-inf'], 0 .. $#sawtooth;

	# The longest consecutive list ends at the position of the maximum
	# and has one more element than the maximum in the sawtooth list.
	# Extract this sublist from the ordered list.  Empty the result list
	# if the maximum is zero, i.e.  if the lcs consists of a single
	# number.
	(@sorted[$maxat->[1] - $maxat->[0] .. $maxat->[1]]) x !!$maxat->[0];
}

is [lcs 100, 4, 50, 3, 2], [2, 3, 4], 'Example 1';
is lcs(20, 30, 10, 40, 50), F(), 'Example 2';
is [lcs 20, 19, 9, 11, 10], [9, 10, 11], 'Example 3';

is [lcs 1, 2, 3, 11, 12, 13, 14, 21, 22], [11, 12, 13, 14], 'max != index';
is [lcs 12, 3, 1, 14, 5, 2, 11, 3, 4, 13], [1, 2, 3, 4, 5], 'has duplicate';
is [lcs 1, 2.1, 3.2, 4.3, 5.3, 6.3, 7.2, 8.1, 9], [4.3, 5.3, 6.3],
	'works with broken numbers, too';

done_testing;
