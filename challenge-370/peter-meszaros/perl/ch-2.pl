#!/usr/bin/env perl
#
=head1 Task 2: Scramble String

Submitted by: Roger Bell_West

You are given two strings A and B of the same length.  Write a script to return
true if string B is a scramble of string A otherwise return false.  String B is
a scramble of string A if A can be transformed into B by a single (recursive)
scramble operation.

A scramble operation is:

    - If the string consists of only one character, return the string.
    - Divide the string X into two non-empty parts.
    - Optionally, exchange the order of those parts.
    - Optionally, scramble each of those parts.
    - Concatenate the scrambled parts to return a single string.

=head2 Example 1

    Input: $str1 = "abc", $str2 = "acb"
    Output: true

    "abc"
    split: ["a", "bc"]
    split: ["a", ["b", "c"]]
    swap: ["a", ["c", "b"]]
    concatenate: "acb"

=head2 Example 2

    Input: $str1 = "abcd", $str2 = "cdba"
    Output: true

    "abcd"
    split: ["ab", "cd"]
    swap: ["cd", "ab"]
    split: ["cd", ["a", "b"]]
    swap: ["cd", ["b", "a"]]
    concatenate: "cdba"

=head2 Example 3

    Input: $str1 = "hello", $str2 = "hiiii"
    Output: false

    A fundamental rule of scrambled strings is that they must be anagrams.

=head2 Example 4

    Input: $str1 = "ateer", $str2 = "eater"
    Output: true

    "ateer"
    split: ["ate", "er"]
    split: [["at", "e"], "er"]
    swap: [["e", "at"], "er"]
    concatenate: "eater"

=head2 Example 5

    Input: $str1 = "abcd", $str2 = "bdac"
    Output: false

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["abc",   "acb"],   true,  "Example 1"],
    [["abcd",  "cdba"],  true,  "Example 2"],
    [["hello", "hiiii"], false, "Example 3"],
    [["ateer", "eater"], true,  "Example 4"],
    [["abcd",  "bdac"],  false, "Example 5"],
];

sub scramble_string
{
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];

    my %m;

    my $scrambled;
    $scrambled = sub {
        my $s1 = shift;
        my $s2 = shift;

        return $m{"$s1,$s2"} if exists $m{"$s1,$s2"};
        return false if join('', sort split '', $s1) ne join('', sort split '', $s2);
        return true if length($s1) == 1;

        for my $i (1 .. length($s1) - 1) {
            if ($scrambled->(substr($s1, 0, $i), substr($s2, -$i))    &&
                $scrambled->(substr($s1, $i),    substr($s2, 0, -$i)) ||
                $scrambled->(substr($s1, 0, $i), substr($s2, 0, $i))  &&
                $scrambled->(substr($s1, $i),    substr($s2, $i))) {
                $m{"$s1,$s2"} = true;
                return true;
            }
        }
        $m{"$s1,$s2"} = false;
        return false;
    };
    return $scrambled->($str1, $str2);
}

for (@$cases) {
    is(scramble_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

