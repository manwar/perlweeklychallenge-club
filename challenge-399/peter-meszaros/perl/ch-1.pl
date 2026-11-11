#!/usr/bin/env perl
#
=head1 Task 1: Longest Repeating Character

Submitted by: Mohammad Sajid Anwar

You are given a string str and an integer k > 0.  Write a script to choose any
character of str and change it to another character. You may perform this
operation up to k times. Return the length of the longest reachable substring
of a single letter.

=head2 Example 1

    Input: $str = "AAAAA", $k = 2
    Output: 5

    Every character in the string is already the same letter "A".
    The maximum operations allowed (k = 2) do not even need to be used.
    The entire string of length 5 is already the longest valid substring.

=head2 Example 2

Input: $str = "ABCDE", $k = 4
Output: 5

    All 5 characters in the string are distinct.
    The most frequent character occurs only 1 time.
    To turn the entire string into a single repeated character, we need to replace 5 - 1 = 4 characters.
    Since k = 4, we can replace "B","C","D", and "E" with "A" to form "AAAAA".

=head2 Example 3

    Input: $str = "AAABBBBAA", $k = 1
    Output: 5

    If we target "A", we could change the "B" in "AAAB" (k=1 replacement) to get length 4 ("AAAA").
    If we target "B", we can pick the substring "BBBBA" and change the single
    trailing "A" to "B" (k=1 replacement) to form "BBBBB", which gives a length of 5.
    Targeting "B" gives better result than targeting "A".

=head2 Example 4

    Input: $str = "ABACADA", $k = 2
    Output: 5

    Look at the substring [0..4] which is "ABACA" (length 5).
    In this window, "A" appears 3 times, and there are 2 non-"A" characters ("B" and "C").
    With k = 2, we can replace "B" and "C" with "A" to form "AAAAA".

    Look at the substring [2..6] which is "ACADA" (length 5).
    Here, "A" appears 3 times, and non-"A" characters ("C" and "D") count to 2.
    Replacing them gives "AAAAA".

    In both cases, the maximum valid length is 5.

=head2 Example 5

    Input: $str = "BAAABAAAA", $k = 1
    Output: 8

    The string has two groups of "A"s separated by a single "B" ("AAABAAAA").

    We can replace the character 4 "B" with an "A" to get a sequence of 8 "A".

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/max/;

my @cases = (
    {str => "AAAAA",     k => 2, out => 5, name => 'Example 1'},
    {str => "ABCDE",     k => 4, out => 5, name => 'Example 2'},
    {str => "AAABBBBAA", k => 1, out => 5, name => 'Example 3'},
    {str => "ABACADA",   k => 2, out => 5, name => 'Example 4'},
    {str => "BAAABAAAA", k => 1, out => 8, name => 'Example 5'},
);

sub longest_repeating_character
{
    my $str = shift;
    my $k   = shift;

    my $len = length($str);
    my @count = (0) x 26;
    my $start = 0;
    my $maxCount = 0;
    my $maxLength = 0;

    for (my $end = 0; $end < $len; $end++) {
        $maxCount = max($maxCount, ++$count[ord(substr($str, $end, 1)) - ord('A')]);
        while ($end - $start + 1 - $maxCount > $k) {
            $count[ord(substr($str, $start, 1)) - ord('A')]--;
            $start++;
        }
        $maxLength = max($maxLength, $end - $start + 1);
    }
    return $maxLength;
}

for my $case (@cases) {
    my $got = longest_repeating_character($case->{str}, $case->{k});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;

