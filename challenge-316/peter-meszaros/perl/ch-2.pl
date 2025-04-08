#!/usr/bin/env perl
#
=head1 Task 2: Subsequence

Submitted by: Mohammad Sajid Anwar

You are given two string.

Write a script to find out if one string is a subsequence of another.

A subsequence of a string is a new string that is formed from the original
string by deleting some (can be none)  of the characters without disturbing the
relative positions of the remaining characters.

=head2 Example 1

    Input: $str1 = "uvw", $str2 = "bcudvew"
    Output: true

=head2 Example 2

    Input: $str1 = "aec", $str2 = "abcde"
    Output: false

=head2 Example 3

    Input: $str1 = "sip", $str2 = "javascript"
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["uvw", "bcudvew"],    1, "Example 1"],
    [["aec", "abcde"],      0, "Example 2"],
    [["sip", "javascript"], 1, "Example 3"],
];

sub subsequence
{
    my ($str1, $str2) = @{$_[0]};

    my $re = join(".*", split '', $str1);
    return  $str2 =~ /$re/ ? 1 : 0;
}

for (@$cases) {
    is(subsequence($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
