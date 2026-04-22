#!perl
use strict;
use warnings FATAL => qw(all);

# no warnings 'recursion';

=prompt
You are given two strings A and B of the same length.
Write a script to return true if string B is a scramble of string A otherwise return false.
String B is a scramble of string A if A can be transformed into B by a single (recursive) scramble operation.

A scramble operation is:

- If the string consists of only one character, return the string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.

Example 1

Input: $str1 = "abc", $str2 = "acb"
Output: true
"abc"
split: ["a", "bc"]
split: ["a", ["b", "c"]]
swap: ["a", ["c", "b"]]
concatenate: "acb"

Example 2
Input: $str1 = "abcd", $str2 = "cdba"
Output: true
"abcd"
split: ["ab", "cd"]
swap: ["cd", "ab"]
split: ["cd", ["a", "b"]]
swap: ["cd", ["b", "a"]]
concatenate: "cdba"


Example 3

Input: $str1 = "hello", $str2 = "hiiii"
Output: false

A fundamental rule of scrambled strings is that they must be anagrams.

Example 4

Input: $str1 = "ateer", $str2 = "eater"
Output: true

"ateer"
split: ["ate", "er"]
split: [["at", "e"], "er"]
swap: [["e", "at"], "er"]
concatenate: "eater"

Example 5

Input: $str1 = "abcd", $str2 = "bdac"
Output: false
=cut




use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(is_scramble("abc", "acb"), true, 'Example 1');
is(is_scramble("abcd", "cdba"), true, 'Example 2');
is(is_scramble("hello", "hiiii"), false, 'Example 3');
is(is_scramble("ateer", "eater"), true, 'Example 4');
is(is_scramble("abcd", "bdac"), false, 'Example 5');

done_testing();

sub is_scramble
{
     my ($str_1, $str_2) = @_;
     my $len_1 = length($str_1);
     return false if $len_1 != length($str_2);
     return true if ($str_1 eq $str_2);

     my $alphabet_1 = make_alphabet($str_1);
     my $alphabet_2 = make_alphabet($str_2);
     return false if ($alphabet_1 ne $alphabet_2);
     
     for my $idx ( 1 .. $len_1 - 1 )
     {
          my $left_1       = substr($str_1, 0, $idx);
          my $right_1      = substr($str_1, $idx);
          my $left_2       = substr($str_2, 0, $idx);
          my $right_2      = substr($str_2, $idx);
          my $left_2_swap  = reverse($left_2);
          my $right_2_swap = reverse($right_2);


          if( ($str_1 eq join('', $right_2, $left_2)) 
               or 
              ($str_1 eq join('', $right_2, $left_2_swap))
              or
              ($str_1 eq join('', $right_2_swap, $left_2))
              or
              ($str_1 eq join('', $right_2_swap, $left_2_swap))
              or
              ($str_1 eq join('', $left_2, $right_2_swap))
              or
              ($str_1 eq join('', $left_2_swap, $right_2_swap))
              or
              ($str_1 eq join('', $left_2_swap, $right_2))
              )
          {
               return true;
          }
          
          
          if (is_scramble($left_1, $left_2) and is_scramble($right_1, $right_2))
          {
               return true;
          }
          if (is_scramble($left_1, $left_2_swap) and is_scramble($right_1, $right_2_swap))
          {
               return true;
          }
     }
     return false;
}


sub make_alphabet
{
     my $str = $_[0];
     return join('', sort { $a cmp $b } split(//, $str));
}
