#!/usr/bin/env perl
#
=head1 Task 1: Group Position

Submitted by: Mohammad Sajid Anwar

You are given a string of lowercase letters.

Write a script to find the position of all groups in the given string. Three or
more consecutive letters form a group. Return "” if none found.

=head2 Example 1

    Input: $str = "abccccd"
    Output: "cccc"

=head2 Example 2

    Input: $str = "aaabcddddeefff"
    Output: "aaa", "dddd", "fff"

=head2 Example 3

    Input: $str = "abcdd"
    Output: ""

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["abccccd",        ["cccc"],               "Example 1"],
    ["aaabcddddeefff", ["aaa", "dddd", "fff"], "Example 2"],
    ["abcdd",          [""],                   "Example 3"],
];

sub group_position
{
    my $str = shift;
    my @groups;

    while ($str =~ /([a-z])\1{2,}/g) {
        push @groups, $&;
    }
    return @groups ? \@groups : [""];
}

for (@$cases) {
    is(group_position($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
