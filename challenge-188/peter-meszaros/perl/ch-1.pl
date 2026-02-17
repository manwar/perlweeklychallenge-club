#!/usr/bin/env perl
#
=head1 Task 1: Divisible Pairs

Submitted by: Mohammad S Anwar

You are given list of integers @list of size $n and divisor $k.  Write a script
to find out count of pairs in the given list that satisfies the following
rules.  The pair (i, j) is eligible if and only if

    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

=head2 Example 1

    Input: @list = (4, 5, 1, 6), $k = 2
    Output: 2

=head2 Example 2

    Input: @list = (1, 2, 3, 4), $k = 2
    Output: 2

=head2 Example 3

    Input: @list = (1, 3, 4, 5), $k = 3
    Output: 2

=head2 Example 4

    Input: @list = (5, 1, 2, 3), $k = 4
    Output: 2

=head2 Example 5

    Input: @list = (7, 2, 4, 5), $k = 4
    Output: 1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[4, 5, 1, 6], 2], 2, "Example 1"],
    [[[1, 2, 3, 4], 2], 2, "Example 2"],
    [[[1, 3, 4, 5], 3], 2, "Example 3"],
    [[[5, 1, 2, 3], 4], 2, "Example 4"],
    [[[7, 2, 4, 5], 4], 1, "Example 5"],
];

sub divisible_pairs
{
    my $list = $_[0]->[0];
    my $k    = $_[0]->[1];

    my $count = 0;
    for my $i (0 .. $#$list - 1) {
        for my $j ($i + 1 .. $#$list) {
            $count++ unless ($list->[$i] + $list->[$j]) % $k;
        }
    }
    return $count;
}

for (@$cases) {
    is(divisible_pairs($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
