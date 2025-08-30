#!/usr/bin/env perl
#
=head1 Task 1: Equal Group

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return true if the given array can be divided into one or
more groups: each group must be of the same size as the others, with at least
two members, and with all members having the same value.

=head2 Example 1

    Input: @ints = (1,1,2,2,2,2)
    Output: true

    Groups: (1,1), (2,2), (2,2)

=head2 Example 2

    Input: @ints = (1,1,1,2,2,2,3,3)
    Output: false

    Groups: (1,1,1), (2,2,2), (3,3)

=head2 Example 3

    Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
    Output: true

    Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)

=head2 Example 4

    Input: @ints = (1,2,3,4)
    Output: false

=head2 Example 5

    Input: @ints = (8,8,9,9,10,10,11,11)
    Output: true

    Groups: (8,8), (9,9), (10,10), (11,11)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1,1,2,2,2,2],             1, "Example 1"],
    [[1,1,1,2,2,2,3,3],         0, "Example 2"],
    [[5,5,5,5,5,5,7,7,7,7,7,7], 1, "Example 3"],
    [[1,2,3,4],                 0, "Example 4"],
    [[8,8,9,9,10,10,11,11],     1, "Example 5"],
];

sub equal_group
{
    my ($ints) = @_;

    my %count;
    $count{$_}++ for @$ints;
    my @values = values %count;
    my $min = $values[0];
    for my $v (@values[1 .. $#values]) {
        $min = $v if $v < $min;
    }
    return 0 if $min < 2;

    for my $size (2 .. $min) {
        my $ok = 1;
        for my $v (@values) {
            if ($v % $size != 0) {
                $ok = 0;
                last;
            }
        }
        return 1 if $ok;
    }
    return 0;
}

for (@$cases) {
    is(equal_group($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
