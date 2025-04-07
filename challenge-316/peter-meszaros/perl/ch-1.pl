#!/usr/bin/env perl
#
=head1 Task 1: Circular

Submitted by: Mohammad Sajid Anwar

You are given a list of words.

Write a script to find out whether the last character of each word is the first
character of the following word.

=head2 Example 1

    Input: @list = ("perl", "loves", "scala")
    Output: true

=head2 Example 2

    Input: @list = ("love", "the", "programming")
    Output: false

=head2 Example 3

    Input: @list = ("java", "awk", "kotlin", "node.js")
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["perl", "loves", "scala"],           1, "Example 1"],
    [["love", "the", "programming"],       0, "Example 2"],
    [["java", "awk", "kotlin", "node.js"], 1, "Example 3"],
];

sub circular
{
    my $list = shift;

    for my $i (0 .. $#$list - 1) {
        return 0 if substr($list->[$i], -1, 1) ne substr($list->[$i + 1], 0, 1);
    }

    return 1;
}

for (@$cases) {
    is(circular($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
