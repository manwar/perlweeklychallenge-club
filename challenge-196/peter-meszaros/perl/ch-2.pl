#!/usr/bin/env perl
#
=head1 Task 2: Range List

Submitted by: Mohammad S Anwar

You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range all
integers from x and y (both inclusive).

    Each subsequence of two or more contiguous integers

=head2 Example 1

    Input: @array = (1,3,4,5,7)
    Output: [3,5]

=head2 Example 2

    Input: @array = (1,2,3,6,7,9)
    Output: [1,3], [6,7]

=head2 Example 3

    Input: @array = (0,1,2,4,5,6,8,9)
    Output: [0,2], [4,6], [8,9]

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 3, 4, 5, 7],          [[3, 5]],                 'Example 1'],
    [[1, 2, 3, 6, 7, 9],       [[1, 3], [6, 7]],         'Example 2'],
    [[0, 1, 2, 4, 5, 6, 8, 9], [[0, 2], [4, 6], [8, 9]], 'Example 3'],
];

sub range_list
{
    my $l = shift;

    my @res;
    my $start;
    for (my $i = 0; $i < @$l; $i++) {
        $start = $l->[$i] unless defined $start;
        if ($i == @$l - 1 || $l->[$i] + 1 != $l->[$i + 1]) {
            push @res, [$start, $l->[$i]] if $l->[$i] != $start;
            undef $start;
        }
    }

    return \@res;
}

for (@$cases) {
    is(range_list($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
