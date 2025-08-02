#!/usr/bin/env perl
#
=head1 Task 1: Last Word

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the length of last word in the given string.

=head2 Example 1

    Input: $str = "The Weekly Challenge"
    Output: 9

=head2 Example 2

    Input: $str = "   Hello   World    "
    Output: 5

=head2 Example 3

    Input: $str = "Let's begin the fun"
    Output: 3

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["The Weekly Challenge", 9, "Example 1"],
    ["   Hello   World    ", 5, "Example 2"],
    [ "Let's begin the fun", 3, "Example 3"],
    [ "                   ", 0, "Example 4"],
];

sub last_word
{
    my $str = shift;

    my @words = split /\s+/, $str;
    return @words ? length $words[-1] : 0;
}

for (@$cases) {
    is(last_word($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
