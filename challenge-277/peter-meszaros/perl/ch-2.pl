#!/usr/bin/env perl
#
=head1 Task 2: Strong Pair

You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

    A pair of integers x and y is called strong pair if it satisfies:
    0 < |x - y| < min(x, y).

=head2 Example 1

    Input: @ints = (1, 2, 3, 4, 5)
    Ouput: 4

    Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

=head2 Example 2

    Input: @ints = (5, 7, 1, 7)
    Ouput: 1

    Strong Pairs: (5, 7)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/min uniqint/;
use Algorithm::Combinatorics qw/combinations/;

my $cases = [
    [[1, 2, 3, 4, 5], 4],
    [[5, 7, 1, 7],    1],
];

sub strong_pair
{
    my $ints = shift;

    my $cnt = 0;
    my $iter = combinations([uniqint @$ints], 2);
    while (my $c = $iter->next) {
        my $abs = abs($c->[0] - $c->[1]);
        my $min = min($c->[0], $c->[1]);
        $cnt++ if 0 < $abs && $abs < $min;
    }

    return $cnt;
}

for (@$cases) {
    is(strong_pair($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

