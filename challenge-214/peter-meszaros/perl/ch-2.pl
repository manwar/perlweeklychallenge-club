#!/usr/bin/env perl
#
=head1 Task 2: Collect Points

Submitted by: Mohammad S Anwar

You are given a list of numbers.

You will perform a series of removal operations. For each operation, you remove
from the list N (one or more) equal and consecutive numbers, and add to your
score N x N.

Determine the maximum possible score.

=head2 Example 1:

    Input: @numbers = (2,4,3,3,3,4,5,4,2)
    Output: 23

    We see three 3's next to each other so let us remove that first and collect 3 x 3 points.
    So now the list is (2,4,4,5,4,2).
    Let us now remove 5 so that all 4's can be next to each other and collect 1 x 1 point.
    So now the list is (2,4,4,4,2).
    Time to remove three 4's and collect 3 x 3 points.
    Now the list is (2,2).
    Finally remove both 2's and collect 2 x 2 points.
    So the total points collected is 9 + 1 + 9 + 4 => 23.

=head2 Example 2:

    Input: @numbers = (1,2,2,2,2,1)
    Output: 20

    Remove four 2's first and collect 4 x 4 points.
    Now the list is (1,1).
    Finally remove the two 1's and collect 2 x 2 points.
    So the total points collected is 16 + 4 => 20.

=head2 Example 3:

    Input: @numbers = (1)
    Output: 1

=head2 Example 4:

    Input: @numbers = (2,2,2,1,1,2,2,2)
    Output: 40

    Remove two 1's = 2 x 2 points.
    Now the list is (2,2,2,2,2,2).
    Then reomove six 2's = 6 x 6 points.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[2, 4, 3, 3, 3, 4, 5, 4, 2], 23, 'Example 1'],
    [[1, 2, 2, 2, 2, 1],          20, 'Example 2'],
    [[1],                          1, 'Example 3'],
    [[2, 2, 2, 1, 1, 2, 2, 2],    40, 'Example 4'],
];

# Based on https://www.geeksforgeeks.org/remove-consecutive-repeated-numbers/
my %dp;

sub solver
{
	my ($numbers, $l, $r, $k) = @_;

	# Base case: if left index exceeds right index, return 0
	return 0 if $l > $r;

	# Compute a unique key for memoization
	my $key = ($l * @$numbers + $r) * @$numbers + $k;
 
	# Check if result for current state is already computed
	return $dp{$key} if defined $dp{$key};
 
	# Handle consecutive repeated numbers at the right end of the range
 	while ($r > $l && $numbers->[$r] == $numbers->[$r-1]) {
 		$r--;
 		$k++;
 	}
 
	# Handle consecutive repeated numbers at the left end of the range
 	while ($r > $l && $numbers->[$l] == $numbers->[$r]) {
 		$l++;
 		$k++;
 	}
 
	# Update key after handling consecutive repeats
 	$key = ($l * @$numbers + $r) * @$numbers + $k;
 
	# Calculate result by recursively solving subproblems
 	$dp{$key} = solver($numbers, $l, $r-1, 0) + ($k+1)**2;
 
 	#for (my $i = $l; $i < $r; $i++) {
 	for my $i ($l .. $r-1) {
 		if ($numbers->[$i] == $numbers->[$r]) {
 			while ($i+1 < $r and $numbers->[$i+1] == $numbers->[$r]) {
 				$i++;
			}
			# After taking similar characters from left let the left range be
			# partof the right range and hence add K+1 to previously going on
			# range, and for the range that is left start from k=0 and try
			# removing new sub ranges of similar numbers from this range.
 			$dp{$key} = max($dp{$key}, solver($numbers, $l,   $i,   $k+1)
 						    	     + solver($numbers, $i+1, $r-1,    0));
 		}
 	}
 
	# Return the computed result for this state
 	return $dp{$key};
}

sub collect_points
{
    my $numbers = shift;

	return solver($numbers, 0, (scalar @$numbers) - 1, 0);
}

for (@$cases) {
    is(collect_points($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
