#!/usr/bin/env perl
#
=head1 Task 2: Wiggle Sort

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.

    Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]...

=head2 Example 1

    Input: @list = (1,5,1,1,6,4)
    Output: (1,6,1,5,1,4)

=head2 Example 2

    Input: @list = (1,3,2,2,3,1)
    Output: (2,3,1,3,1,2)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    #[[1, 5, 1, 1, 6, 4], [1, 6, 1, 5, 1, 4], 'Example 1'],
    #[[1, 3, 2, 2, 3, 1], [2, 3, 1, 3, 1, 2], 'Example 2'],
    [[1, 5, 1, 1, 6, 4], [ 1, 5, 1, 6, 1, 4 ], 'Example 1'],
    [[1, 3, 2, 2, 3, 1], [ 1, 3, 2, 3, 1, 2 ], 'Example 2'],
];

sub wiggle_sort
{
    my $l = shift;

    for my $i (1 .. $#$l) {
        my $odd_index = $i % 2;
        if ( $odd_index && $l->[$i] < $l->[$i-1] or
            !$odd_index && $l->[$i] > $l->[$i-1]) {
            ($l->[$i], $l->[$i-1]) = ($l->[$i-1], $l->[$i]);
        }
    }

    return $l;
}

for (@$cases) {
    is(wiggle_sort($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
