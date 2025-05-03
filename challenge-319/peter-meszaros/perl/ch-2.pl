#!/usr/bin/env perl
#
=head1 Task 2: Minimum Common

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers.

Write a script to return the minimum integer common to both arrays. If none
found return -1.

=head2 Example 1

    Input: @array_1 = (1, 2, 3, 4)
           @array_2 = (3, 4, 5, 6)
    Output: 3

    The common integer in both arrays: 3, 4
    The minimum is 3.

=head2 Example 2

    Input: @array_1 = (1, 2, 3)
           @array_2 = (2, 4)
    Output: 2

=head2 Example 3

    Input: @array_1 = (1, 2, 3, 4)
           @array_2 = (5, 6, 7, 8)
    Output: -1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 2, 3, 4], [3, 4, 5, 6]],  3, "Example 1"],
    [[[1, 2, 3],    [2, 4]],        2, "Example 2"],
    [[[1, 2, 3, 4], [5, 6, 7, 8]], -1, "Example 3"],
];

sub minimum_common
{
    my ($array1, $array2) = $_[0]->@*;

    my %hash1 = map { $_ => 1 } @$array1;
    my @sorted2 = sort {$a <=> $b} @$array2;

    my @x = @hash1{@sorted2};

    for (my $i = 0; $i < @x; $i++) {
        return $sorted2[$i] if $x[$i];
    }
    return -1;
}

for (@$cases) {
    is(minimum_common($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
