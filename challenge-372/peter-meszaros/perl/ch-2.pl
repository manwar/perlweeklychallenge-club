#!/usr/bin/env perl
#
=head1 Task 2: Largest Substring

Submitted by: Mohammad Sajid Anwar

You are given a string.  Write a script to return the length of the largest
substring between two equal characters excluding the two characters. Return -1
if there is no such substring.

=head2 Example 1

    Input: $str = "aaaaa"
    Output: 3

    For character "a", we have substring "aaa".

=head2 Example 2

    Input: $str = "abcdeba"
    Output: 5

    For character "a", we have substring "bcdeb".

=head2 Example 3

    Input: $str = "abbc"
    Output: 0

    For character "b", we have substring "".

=head2 Example 4

    Input: $str = "abcaacbc"
    Output: 4

    For character "a", we have substring "bca".
    For character "b", we have substring "caac".
    For character "c", we have substring "aacb".

=head2 Example 5

    Input: $str = "laptop"
    Output: 2

    For character "p", we have substring "to".

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["aaaaa",    3, "Example 1"],
    ["abcdeba",  5, "Example 2"],
    ["abbc",     0, "Example 3"],
    ["abcaacbc", 4, "Example 4"],
    ["laptop",   2, "Example 5"],
];

sub largest_substring
{
    my $str = shift;
    my %seen;
    my $max = -1;

    for my $i (0 .. length($str) - 1) {
        my $c = substr($str, $i, 1);
        if (exists $seen{$c}) {
            my $len = $i - $seen{$c} - 1;
            $max = $len if $len > $max;
        } else {
            $seen{$c} = $i;
        }
    }

    return $max;
}

for (@$cases) {
    is(largest_substring($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
