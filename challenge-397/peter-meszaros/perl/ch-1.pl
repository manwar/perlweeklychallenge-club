#!/usr/bin/env perl
#
=head1 Task 1: Absent Smallest Positive

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.  Write a script to return the smallest
absent positive integer such that it is strictly greater than the average of
all elements in the given array.

=head2 Example 1

    Input: @arr = (1, 2, 4, 5, 6)
    Output: 7

    Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
    We need the smallest positive integer absent from nums that is strictly greater than 3.6.
    The positive integers greater than 3.6 are 4, 5, 6, 7, ....

    4 is in the given array.
    5 is in the given array.
    6 is in the given array.
    7 is not in.

=head2 Example 2

    Input: @arr = (-5, -2, -1, 3)
    Output: 1

    Average: (-5 -2 -1 + 3) / 4 = -1.25
    We need the smallest absent positive integer strictly greater than -1.25.
    Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).

    1 is positive and absent from the given array.

=head2 Example 3

    Input: @arr = (1, 2, 3)
    Output: 4

    Average: (1 + 2 + 3) / 3 = 2.0
    We need an integer strictly greater than 2.0.

    3 is in the given array.
    4 is not in.

=head2 Example 4

    Input: @arr = (2, 3, 7, 8)
    Output: 6

    Average: (2 + 3 + 7 + 8) / 4 = 5.0
    We need an integer strictly greater than 5.0.

    6 is not in the given array.

=head2 Example 5

    Input: @arr = (1, 1, 1, 10)
    Output: 4

    Average: (1 + 1 + 1 + 10) / 4 = 3.25
    Positive integers strictly greater than 3.25: 4, 5, 6, ...

    4 is not in the given array.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/sum0/;


my @cases = (
    {arr => [1, 2, 4, 5, 6], out => 7, name => 'Example 1'},
    {arr => [-5, -2, -1, 3], out => 1, name => 'Example 2'},
    {arr => [1, 2, 3],       out => 4, name => 'Example 3'},
    {arr => [2, 3, 7, 8],    out => 6, name => 'Example 4'},
    {arr => [1, 1, 1, 10],   out => 4, name => 'Example 5'},
);

sub absent_smallest_positive
{
    my $arr = shift;

    my $num = sum0(@$arr) / @$arr;
    $num = $num <= 0 ? 1 : int($num) + 1;

    my %arr = map {$_, 1} @$arr;
    ++$num while $arr{$num};

    return $num;
}

for my $case (@cases) {
    my $got = absent_smallest_positive($case->{arr});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
