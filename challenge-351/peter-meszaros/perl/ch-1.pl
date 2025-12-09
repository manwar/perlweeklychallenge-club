#!/usr/bin/env perl
#
=head1 Task 1: Special Average

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the
given array.

=head2 Example 1

    Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
    Output: 5250

    Min: 2000
    Max: 8000
    Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

=head2 Example 2

    Input: @ints = (100_000, 80_000, 110_000, 90_000)
    Output: 95_000

    Min: 80_000
    Max: 110_000
    Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

=head2 Example 3

    Input: @ints = (2500, 2500, 2500, 2500)
    Output: 0

    Min: 2500
    Max: 2500
    Avg: 0

=head2 Example 4

    Input: @ints = (2000)
    Output: 0

    Min: 2000
    Max: 2000
    Avg: 0

=head2 Example 5

    Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
    Output: 3500

    Min: 1000
    Max: 6000
    Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[8000, 5000, 6000, 2000, 3000, 7000], 5250, "Example 1"],
    [[100_000, 80_000, 110_000, 90_000], 95_000, "Example 2"],
    [[2500, 2500, 2500, 2500],                0, "Example 3"],
    [[2000],                                  0, "Example 4"],
    [[1000, 2000, 3000, 4000, 5000, 6000], 3500, "Example 5"],
];

sub special_average
{
    my $ints = shift;

    my ($min, $max);
    for my $i (@$ints) {
        $min = $i if !defined($min) || $i < $min;
        $max = $i if !defined($max) || $i > $max;
    }
    my $avg = 0;
    my $cnt = 0;
    for my $i (@$ints) {
        next if $i == $min || $i == $max;
        ++$cnt;
        $avg += ($i - $avg) / $cnt;
    }
    return $avg;
}

for (@$cases) {
    is(special_average($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
