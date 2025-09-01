#!/usr/bin/env perl
#
=head1 Task 1: Smaller Than Current

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers, @num1.

Write a script to return an array, @num2, where $num2[i] is the count of all
numbers less than or equal to $num1[i].

=head2 Example 1

    Input: @num1 = (6, 5, 4, 8)
    Output: (2, 1, 0, 3)

    index 0: numbers <= 6 are 5, 4    => 2
    index 1: numbers <= 5 are 4       => 1
    index 2: numbers <= 4, none       => 0
    index 3: numbers <= 8 are 6, 5, 4 => 3

=head2 Example 2

    Input: @num1 = (7, 7, 7, 7)
    Output: (3, 3, 3, 3)

=head2 Example 3

    Input: @num1 = (5, 4, 3, 2, 1)
    Output: (4, 3, 2, 1, 0)

=head2 Example 4

    Input: @num1 = (-1, 0, 3, -2, 1)
    Output: (1, 2, 4, 0, 3)

=head2 Example 5

    Input: @num1 = (0, 1, 1, 2, 0)
    Output: (1, 3, 3, 4, 1)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[ 6, 5, 4,  8],    [2, 1, 0, 3],    "Example 1"],
    [[ 7, 7, 7,  7],    [3, 3, 3, 3],    "Example 2"],
    [[ 5, 4, 3,  2, 1], [4, 3, 2, 1, 0], "Example 3"],
    [[-1, 0, 3, -2, 1], [1, 2, 4, 0, 3], "Example 4"],
    [[ 0, 1, 1,  2, 0], [1, 3, 3, 4, 1], "Example 5"],
];

sub smaller_than_current
{
    my ($nums) = @_;

    my @result;
    for my $i (0 .. $#$nums) {
        my $count = 0;
        for my $j (0 .. $#$nums) {
            $count++ if $nums->[$j] <= $nums->[$i];
        }
        push @result, $count - 1;
    }
    return \@result;
}

for (@$cases) {
    is(smaller_than_current($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
