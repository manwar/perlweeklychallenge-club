#!/usr/bin/env perl
#
=head1 Task 2: Left Right Sum Diff

You are given an array of integers, @ints.

Write a script to return left right sum diff array as shown below:

	@ints = (a, b, c, d, e)

	@left  = (0, a, (a+b), (a+b+c))
	@right = ((c+d+e), (d+e), e, 0)
	@left_right_sum_diff = ( | 0 - (c+d+e) |,
							 | a - (d+e)   |,
							 | (a+b) - e   |,
							 | (a+b+c) - 0 | )

=head2 Example 1:

	Input: @ints = (10, 4, 8, 3)
	Output: (15, 1, 11, 22)

	@left  = (0, 10, 14, 22)
	@right = (15, 11, 3, 0)

	@left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
						 = (15, 1, 11, 22)

=head2 Example 2:

	Input: @ints = (1)
	Output: (0)

	@left  = (0)
	@right = (0)

	@left_right_sum_diff = ( |0-0| ) = (0)

=head2 Example 3:

	Input: @ints = (1, 2, 3, 4, 5)
	Output: (14, 11, 6, 1, 10)

	@left  = (0, 1, 3, 6, 10)
	@right = (14, 12, 9, 5, 0)

	@left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
						 = (14, 11, 6, 1, 10)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/uniqint/;

my $cases = [
    [[10, 4, 8, 3],   [15, 1, 11, 22]],
    [[1],             [0]],
    [[1, 2, 3, 4, 5], [14, 11, 6, 1, 10]],
];

sub left_rigth_sum_diff
{
    my $l = shift;

    my (@left, @rght);

    $left[0] = $rght[$#$l] = 0;
    for my $i (0 .. $#$l) {
        my $v = $l->[$i];
        $left[$_] += $v for  $i+1 .. $#$l;
        $rght[$_] += $v for  0    .. $i-1;
    }

    my @res;
    $res[$_] = abs($left[$_] - $rght[$_]) for 0 .. $#$l;

    return \@res;
}

for (@$cases) {
    is(left_rigth_sum_diff($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

