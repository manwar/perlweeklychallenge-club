#!/usr/bin/env perl
#
=head1 Task 1: Contiguous Array

Submitted by: Mohammad Sajid Anwar

You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an
equal number of 0 and 1.

=head2 Example 1

    Input: @binary = (1, 0)
    Output: 2

    (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

=head2 Example 2

    Input: @binary = (0, 1, 0)
    Output: 2

    (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of
    0 and 1.

=head2 Example 3

    Input: @binary = (0, 0, 0, 0, 0)
    Output: 0

=head2 Example 4

    Input: @binary = (0, 1, 0, 0, 1, 0)
    Output: 4

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
    [[1, 0],             2, 'Example 1'],
    [[0, 1, 0],          2, 'Example 2'],
    [[0, 0, 0, 0, 0],    0, 'Example 3'],
    [[0, 1, 0, 0, 1, 0], 4, 'Example 4'],
];

sub contiguous_array
{
    my $l = shift;

    my $len = @$l;

    for (my $i=$len; $i > 1; --$i) {
        for my $j (0 .. ($len-$i)) {
            my $sum = sum0($l->@[$j .. $j+$i-1]);
            return $i if $sum == $i/2;
        }
    }

    return 0;
}

for (@$cases) {
    is(contiguous_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
