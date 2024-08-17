#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str.

Write a script to return the score of the given string.

    The score of a string is defined as the sum of the absolute difference between the ASCII values of adjacent characters.

Example 1

Input: $str = "hello"
Output: 13

ASCII values of characters:
h = 104
e = 101
l = 108
l = 108    
o = 111

Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
      => 3 + 7 + 0 + 3
      => 13

Example 2

Input: "perl"
Output: 30

ASCII values of characters:
p = 112
e = 101
r = 114
l = 108

Score => |112 - 101| + |101 - 114| + |114 - 108|
      => 11 + 13 + 6
      => 30

Example 3

Input: "raku"
Output: 37

ASCII values of characters:
r = 114
a = 97
k = 107
u = 117

Score => |114 - 97| + |97 - 107| + |107 - 117|
      => 17 + 10 + 10
      => 37
=cut

use Test2::V0;

is(string_score('hello'), 13, 'Example 1');
is(string_score('perl'), 30, 'Example 2');
is(string_score('raku'), 37, 'Example 3');
done_testing();



sub string_score
{
     my $str = $_[0];
     my %ascii = map { chr($_) => $_ } 32 .. 126;
     my @arr = map $ascii{$_}, split(//, $str);
     my $score = 0;
     for my $idx ( 0 .. $#arr - 1 )
     {
          $score += abs($arr[$idx] - $arr[$idx + 1]);
     }
     return $score;
}