#!/usr/bin/env perl
#
=head1 Task 1: Count Common

Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.

=head2 Example 1

    Input: @str1 = ("perl", "weekly", "challenge")
           @str2 = ("raku", "weekly", "challenge")
    Output: 2

=head2 Example 2

    Input: @str1 = ("perl", "raku", "python")
           @str2 = ("python", "java")
    Output: 1

=head2 Example 3

    Input: @str1 = ("guest", "contribution")
           @str2 = ("fun", "weekly", "challenge")
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["perl",  "weekly", "challenge"], ["raku",   "weekly", "challenge"]], 2, "Example 1"],
    [[["perl",  "raku",   "python"],    ["python", "java"]],                1, "Example 2"],
    [[["guest", "contribution"],        ["fun",    "weekly", "challenge"]], 0, "Example 3"],
];

sub count_common
{
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];

    my %h1 = map {$_ => 1} @$str1;
    return grep { $h1{$_} } @$str2;
}

for (@$cases) {
    is(count_common($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
