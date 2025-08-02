#!/usr/bin/env perl
#
=head1 Task 2: Sort Column

Submitted by: Mohammad Sajid Anwar

You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non
sorted columns.

Return the total columns deleted.

=head2 Example 1

    Input: @list = ("swpc", "tyad", "azbe")
    Output: 2

    swpc
    tyad
    azbe

    Column 1: "s", "t", "a" => non sorted
    Column 2: "w", "y", "z" => sorted
    Column 3: "p", "a", "b" => non sorted
    Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.

=head2 Example 2

    Input: @list = ("cba", "daf", "ghi")
    Output: 1

=head2 Example 3

    Input: @list = ("a", "b", "c")
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["swpc", "tyad", "azbe"], 2, "Example 1"],
    [[ "cba",  "daf",  "ghi"], 1, "Example 2"],
    [[   "a",    "b",    "c"], 0, "Example 3"],
];

sub sort_column
{
    my $list = shift;

    my @col;
    for my $w (@$list) {
        my @w = split '', $w;
        push $col[$_]->@*, $w[$_] for (0 .. $#w);
    }
    my $delete = 0;
    for my $c (@col) {
        my $srtd = join '', sort $c->@*;
        my $orig = join '', $c->@*;
        $delete++ if $srtd ne $orig;
    }
    return $delete;
}

for (@$cases) {
    is(sort_column($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
