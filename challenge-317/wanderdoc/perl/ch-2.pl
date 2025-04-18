#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings.

Write a script to return true if swapping any two letters in one string match the other string, return false otherwise.
Example 1

Input: $str1 = "desc", $str2 = "dsec"
Output: true

Example 2

Input: $str1 = "fuck", $str2 = "fcuk"
Output: true

Example 3

Input: $str1 = "poo", $str2 = "eop"
Output: false

Example 4

Input: $str1 = "stripe", $str2 = "sprite"
Output: true
=cut

use constant {true => 1, false => 0};
use Test2::V0 -no_srand => 1;


is(are_friendly("desc", "dsec"), true, 'Example 1');
is(are_friendly("fuck", "fcuk"), true, 'Example 2');
is(are_friendly("poo", "eop"), false, 'Example 3');
is(are_friendly("stripe", "sprite"), true, 'Example 4');
done_testing();



sub are_friendly
{
     my ($str_1, $str_2) = @_;
     return false if (length($str_1) != length($str_2));
     my @diff = split(//, $str_1 ^ $str_2);
     my @idx = grep { $diff[$_] !~ /\x00/} 0 .. $#diff;
     return false if (scalar @idx != 2);

     return (substr($str_1, $idx[0], 1) eq substr($str_2, $idx[1], 1) 
               and 
             substr($str_1, $idx[1], 1) eq substr($str_2, $idx[0], 1)) 
             ? true: false;
}
