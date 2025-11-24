#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.
Write a script to return the power of the given string.

    The power of the string is the maximum length of a non-empty substring that contains only one unique character.


Example 1

Input: $str = "textbook"
Output: 2

Breakdown: "t", "e", "x", "b", "oo", "k"
The longest substring with one unique character is "oo".


Example 2

Input: $str = "aaaaa"
Output: 5


Example 3

Input: $str = "hoorayyy"
Output: 3

Breakdown: "h", "oo", "r", "a", "yyy"
The longest substring with one unique character is "yyy".


Example 4

Input: $str = "x"
Output: 1


Example 5

Input: $str = "aabcccddeeffffghijjk"
Output: 4
Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
The longest substring with one unique character is "ffff".
=cut

use Test2::V0 -no_srand => 1;

is(power_string("textbook"), 2, 'Example 1');
is(power_string("aaaaa"), 5, 'Example 2');
is(power_string("hoorayyy"), 3, 'Example 3');
is(power_string("x"), 1, 'Example 4');
is(power_string("aabcccddeeffffghijjk"), 4, 'Example 5');
done_testing();

sub power_string
{
     my $str = $_[0];
     die "Empty string!" unless length($str);
     my $max = 0;
     $str =~ /((?<char>.)\k<char>+)(*SKIP)(?{$max = length($&) > $max ? length($&) : $max})(*FAIL)/;
     return $max > 0 ? $max : 1;
}
