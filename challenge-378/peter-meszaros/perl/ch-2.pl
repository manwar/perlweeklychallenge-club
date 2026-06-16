#!/usr/bin/env perl
#
=head1 Task 2: Sum of Words

Submitted by: Mohammad Sajid Anwar

You are given three strings consisting of lower case English letters 'a' to 'j'
only. The letter value of a = 0, b = 1, c = 3, etc.  Write a script to find if
sum of first two strings return the third string.

=head2 Example 1

    Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
    Output: true

    $str1 = "acb" = 021
    $str2 = "cba" = 210
    $str3 = "cdb" = 231
    $str1 + $str2 = $str3

=head2 Example 2

    Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
    Output: true

    $str1 = "aab" = 001
    $str2 = "aac" = 002
    $str3 = "ad"  = 03

=head2 Example 3

    Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
    Output: false

    $str1 = "bc" = 12
    $str2 = "je" = 94
    $str3 = "jg" = 96

=head2 Example 4

    Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
    Output: true

    $str1 = "a"    = 0
    $str2 = "aaaa" = 0000
    $str3 = "aa"   = 00

=head2 Example 5

    Input: $str1 = "c", $str2 = "d", $str3 = "h"
    Output: false

    $str1 = "c" = 2
    $str2 = "d" = 3
    $str3 = "h" = 7

=head2 Example 6

    Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
    Output: true

    $str1 =  "gfi" =  658
    $str2 =  "hbf" =  715
    $str3 = "bdhd" = 1373

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["acb", "cba",  "cdb"], true,  "Example 1"],
    [["aab", "aac",   "ad"], true,  "Example 2"],
    [["bc",   "je",   "jg"], false, "Example 3"],
    [["a",  "aaaa",   "aa"], true,  "Example 4"],
    [["c",     "d",    "h"], false, "Example 5"],
    [["gfi", "hbf", "bdhd"], true,  "Example 6"],
];

sub sum_of_words
{
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];
    my $str3 = $_[0]->[2];
    
    my $num1 = join '', map { ord($_) - 97 } split //, $str1;
    my $num2 = join '', map { ord($_) - 97 } split //, $str2;
    my $num3 = join '', map { ord($_) - 97 } split //, $str3;

    return $num1 + $num2 == $num3;
}

for (@$cases) {
    is(sum_of_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
