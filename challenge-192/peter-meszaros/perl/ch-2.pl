#!/usr/bin/env perl
#
=head1 Task 2: Equal Distribution

Submitted by: Mohammad S Anwar

You are given a list of integers greater than or equal to zero, @list.  Write a
script to distribute the number so that each members are same. If you succeed
then print the total moves otherwise print -1.  Please follow the rules (as
suggested by Neils van Dijke [2022-11-21 13:00]

    1) You can only move a value of '1' per move
    2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

=head2 Example 1

    Input: @list = (1, 0, 5)
    Output: 4

    Move #1: 1, 1, 4
    (2nd cell gets 1 from the 3rd cell)

    Move #2: 1, 2, 3
    (2nd cell gets 1 from the 3rd cell)

    Move #3: 2, 1, 3
    (1st cell get 1 from the 2nd cell)

    Move #4: 2, 2, 2
    (2nd cell gets 1 from the 3rd cell)

=head2 Example 2

    Input: @list = (0, 2, 0)
    Output: -1

    It is not possible to make each same.

=head2 Example 3

    Input: @list = (0, 3, 0)
    Output: 2

    Move #1: 1, 2, 0
    (1st cell gets 1 from the 2nd cell)

    Move #2: 1, 1, 1
    (3rd cell gets 1 from the 2nd cell)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 0, 5],  4, "Example 1"],
    [[0, 2, 0], -1, "Example 2"],
    [[0, 3, 0],  2, "Example 3"],
];

sub equal_distribution
{
    my $list = shift;
    my $len = @$list;
    my $sum = 0;
    $sum += $_ for @$list;

    return -1 if $sum % $len != 0;

    my $target = $sum / $len;
    my $moves  = 0;
    my $diffs  = [ map { $_ - $target } @$list ];

    for my $i (0 .. $len - 2) {
        if ($diffs->[$i] != 0) {
            $diffs->[$i + 1] += $diffs->[$i];
            $moves += abs($diffs->[$i]);
            $diffs->[$i] = 0;
        }
    }

    return $moves;
}

for (@$cases) {
    is(equal_distribution($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
