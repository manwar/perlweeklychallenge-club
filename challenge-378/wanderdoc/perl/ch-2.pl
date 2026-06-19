#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three strings consisting of lower case English letters ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.
Example 1

Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
Output: true

$str1 = "acb" = 021
$str2 = "cba" = 210
$str3 = "cdb" = 231
$str1 + $str2 = $str3

Example 2

Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
Output: true

$str1 = "aab" = 001
$str2 = "aac" = 002
$str3 = "ad"  = 03

Example 3

Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
Output: false

$str1 = "bc" = 12
$str2 = "je" = 94
$str3 = "jg" = 96

Example 4

Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
Output: true

$str1 = "a"    = 0
$str2 = "aaaa" = 0000
$str3 = "aa"   = 00

Example 5

Input: $str1 = "c", $str2 = "d", $str3 = "h"
Output: false

$str1 = "c" = 2
$str2 = "d" = 3
$str3 = "h" = 7

Example 6

Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
Output: true

$str1 =  "gfi" =  658
$str2 =  "hbf" =  715
$str3 = "bdhd" = 1373
=cut




use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;
is(sum_of_words("acb", "cba", "cdb"), true, "Example 1");
is(sum_of_words("aab", "aac", "ad"), true, "Example 2");
is(sum_of_words("bc", "je", "jg"), false, "Example 3");
is(sum_of_words("a","aaaa", "aa"), true, "Example 4");
is(sum_of_words("c","d", "h"), false, "Example 5");
is(sum_of_words("gfi","hbf", "bdhd"), true, "Example 6");
done_testing();

sub sum_of_words
{
     my @words = @_;
     my %num;
     @num{'a' .. 'z'} = 0 .. 25;
     @words = map { join('', map { $num{$_} } split(//)) } @words;
     return (($words[0] + $words[1]) == $words[2]) || false;
}
