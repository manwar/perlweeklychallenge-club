#!/usr/bin/env perl
#
=head1 Task 2: Order Game

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last
element.

=head2 Example 1

    Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
    Output: 1

    Operation 1:

        min(2, 1) = 1
        max(4, 5) = 5
        min(6, 3) = 3
        max(0, 2) = 2

    Operation 2:

        min(1, 5) = 1
        max(3, 2) = 3

    Operation 3:

        min(1, 3) = 1

=head2 Example 2

    Input: @ints = (0, 5, 3, 2)
    Output: 0

    Operation 1:

        min(0, 5) = 0
        max(3, 2) = 3

    Operation 2:

        min(0, 3) = 0

=head2 Example 3

    Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
    Output: 2

    Operation 1:

        min(9, 2) = 2
        max(1, 4) = 4
        min(5, 6) = 5
        max(0, 7) = 7
        min(3, 1) = 1
        max(3, 5) = 5
        min(7, 9) = 7
        max(0, 8) = 8

    Operation 2:

        min(2, 4) = 2
        max(5, 7) = 7
        min(1, 5) = 1
        max(7, 8) = 8

    Operation 3:

        min(2, 7) = 2
        max(1, 8) = 8

    Operation 4:

        min(2, 8) = 2

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/min max/;

my $cases = [
    [[2, 1, 4, 5, 6, 3, 0, 2],                         1, 'Example 1'],
    [[0, 5, 3, 2],                                     0, 'Example 2'],
    [[9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8], 2, 'Example 3'],
];

sub order_game
{
    my $list = shift;

    while (@$list != 1) {
        my $l = [];
        for (my $i=0; $i < @$list; $i+=2) {
            push @$l, ($i / 2 % 2 ? max($list->[$i], $list->[$i+1])
                                  : min($list->[$i], $list->[$i+1]));
        }
        $list = $l;
    }
    return $list->[0];
}

for (@$cases) {
    is(order_game($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
