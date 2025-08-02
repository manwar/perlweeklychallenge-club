#!/usr/bin/env perl
#
=head1 Task 1: Consecutive One

Submitted by: Mohammad Sajid Anwar

You are given a binary array containing only 0 or/and 1.

Write a script to find out the maximum consecutive 1 in the given array.

=head2 Example 1

Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3

=head2 Example 2

Input: @binary = (0, 0, 0, 0)
Output: 0

=head2 Example 3

Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[0, 1, 1, 0, 1, 1, 1], 3, "Example 1"],
    [[0, 0, 0, 0],          0, "Example 2"],
    [[1, 0, 1, 0, 1, 1],    2, "Example 3"],
];

sub consecutive_one
{
    my $binary = shift;

    my $max_count = 0;
    my $current_count = 0;
    for my $bit (@$binary) {
        if ($bit == 1) {
            $current_count++;
            $max_count = $current_count if $current_count > $max_count;
        } else {
            $current_count = 0;
        }
    }

    return $max_count;
}

for (@$cases) {
    is(consecutive_one($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
