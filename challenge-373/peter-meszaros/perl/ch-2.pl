#!/usr/bin/env perl
#
=head1 Task 2: List Division

Submitted by: Mark Anderson

You are given a list and a non-negative integer.  Write a script to divide the
given list into given non-negative integer equal parts. Return -1 if the
integer is more than the size of the list.

=head2 Example 1

    Input: @list = (1,2,3,4,5), $n = 2
    Output: ((1,2,3), (4,5))

    5 / 2 = 2 remainder 1.
    The extra element goes into the first chunk.

=head2 Example 2

    Input: @list = (1,2,3,4,5,6), $n = 3
    Output: ((1,2), (3,4), (5,6))

    6 / 3 = 2 remainder 0.

=head2 Example 3

    Input: @list = (1,2,3), $n = 2
    Output: ((1,2), (3))

=head2 Example 4

    Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
    Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

=head2 Example 5

    Input: @list = (1,2,3), $n = 4
    Output: -1

=head2 Example 6

    Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
    Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[1,2,3,4,5],            2], [[1,2,3], [4,5]],                                             "Example 1"],
    [[[1,2,3,4,5,6],          3], [[1,2], [3,4], [5,6]],                                        "Example 2"],
    [[[1,2,3],                2], [[1,2], [3]],                                                 "Example 3"],
    [[[1,2,3,4,5,6,7,8,9,10], 5], [[1,2], [3,4], [5,6], [7,8], [9,10]],                         "Example 4"],
    [[[1,2,3],                4], -1,                                                           "Example 5"],
    [[[72,57,89,55,36,84,10,95,99,35], 7], [[72,57], [89,55], [36,84], [10], [95], [99], [35]], "Example 6"],
];

sub list_division
{
    my $list = $_[0]->[0];
    my $n    = $_[0]->[1];

    return -1 if $n > @$list;

    my $size = int(@$list / $n);
    my $rem  = @$list % $n;

    my @result;
    for (1 .. $n) {
        push @result, [splice @$list, 0, $size + ($rem > 0 ? 1 : 0)];
        $rem--;
    }
    return \@result;
}

for (@$cases) {
    is(list_division($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
