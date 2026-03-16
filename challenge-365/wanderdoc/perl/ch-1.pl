#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $str consisting of lowercase English letters, and an integer $k.

Write a script to convert a lowercase string into numbers using alphabet positions (a=1 … z=26), concatenate them to form an integer, then compute the sum of its digits repeatedly $k times, returning the final value.
Example 1

Input: $str = "abc", $k = 1
Output: 6

Conversion: a = 1, b = 2, c = 3 -> 123
Digit sum: 1 + 2 + 3 = 6

Example 2

Input: $str = "az", $k = 2
Output: 9

Conversion: a = 1, z = 26 -> 126
1st sum: 1 + 2 + 6 = 9
2nd sum: 9

Example 3

Input: $str = "cat", $k = 1
Output: 6

Conversion: c = 3, a = 1, t = 20 -> 3120
Digit sum: 3 + 1 + 2 + 0 = 6

Example 4

Input: $str = "dog", $k = 2
Output: 8

Conversion: d = 4, o = 15, g = 7 -> 4157
1st sum: 4 + 1 + 5 + 7 = 17
2nd sum: 1 + 7 = 8

Example 5

Input: $str = "perl", $k = 3
Output: 6

Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
2nd sum: 2+4 = 6
3rd sum: 6
=cut


use List::Util qw(sum);
use Test2::V0 -no_srand => 1;



is(alpha_index_sum("abc", 1), 6, 'Example 1');
is(alpha_index_sum("az", 2), 9, 'Example 2');
is(alpha_index_sum("cat", 1), 6, 'Example 3');
is(alpha_index_sum("dog", 2), 8, 'Example 4');
is(alpha_index_sum("perl", 3), 6, 'Example 5');
done_testing();


sub alpha_index_sum
{
     my $str = $_[0];
     my $k = $_[1];
     my %dict;
     @dict{'a'..'z'} = 1 .. 26;
     my $num = join('', map $dict{$_}, split(//, $str));
     for my $i ( 1 .. $k )
     {
          $num = sum(split(//,$num));
     }
     return $num;
}
