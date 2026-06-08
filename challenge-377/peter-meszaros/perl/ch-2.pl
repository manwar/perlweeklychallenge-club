#!/usr/bin/env perl
#
=head1 Task 2: Prefix Suffix

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.  Write a script to find if the two strings
(str1, str2) in the given array such that str1 is prefix and suffix of str2.
Return the total count of such pairs.

=head2 Example 1

    Input: @array = ("a", "aba", "ababa", "aa")
    Output: 4

    $array[0], $array[1]: "a" is a prefix and suffix of "aba"
    $array[0], $array[2]: "a" is a prefix and suffix of "ababa"
    $array[0], $array[3]: "a" is a prefix and suffix of "aa"
    $array[1], $array[2]: "aba" is a prefix and suffix of "ababa"

=head2 Example 2

    Input: @array = ("pa", "papa", "ma", "mama")
    Output: 2

    $array[0], $array[1]: "pa" is a prefix and suffix of "papa"
    $array[2], $array[3]: "ma" is a prefix and suffix of "mama"

=head2 Example 3

    Input: @array = ("abao", "ab")
    Output: 0

=head2 Example 4

    Input: @array = ("abab", "abab")
    Output: 1

    $array[0], $array[1]: "abab" is a prefix and suffix of "abab"

=head2 Example 5

    Input: @array = ("ab", "abab", "ababab")
    Output: 3

    $array[0], $array[1]: "ab" is a prefix and suffix of "abab"
    $array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
    $array[1], $array[2]: "abab" is a prefix and suffix of "ababab"

=head2 Example 6

    Input: @array = ("abc", "def", "ghij")
    Output: 0

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["a", "aba", "ababa", "aa"],  4, 'Example 1'],
    [["pa", "papa", "ma", "mama"], 2, 'Example 2'],
    [["abao", "ab"],               0, 'Example 3'],
    [["abab", "abab"],             1, 'Example 4'],
    [["ab", "abab", "ababab"],     3, 'Example 5'],
    [["abc", "def", "ghij"],       0, 'Example 6'],
];

sub prefix_suffix
{
    my $array = shift;
    my $count = 0;
    my $equals = 0;

    for my $i (0 .. $#$array) {
        for my $j (0 .. $#$array) {
            next if $i == $j;
            my $str1 = $array->[$i];
            my $str2 = $array->[$j];

            if (substr($str2, 0, length($str1)) eq $str1 &&
                substr($str2, -length($str1)) eq $str1) {
                $count++;
                $equals++ if $str1 eq $str2;    
            }
        }
    }
    $count -= int($equals / 2);

    return $count;
}

for (@$cases) {
    is(prefix_suffix($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
