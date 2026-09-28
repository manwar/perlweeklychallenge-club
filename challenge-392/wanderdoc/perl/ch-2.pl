#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings.

Write a script to return the maximum value of len($words[i]) * len($words[j]) where the two words do not share common letters. If no such two words exist, return 0.
Example 1

Input: @words = ("a", "ab", "abc", "d", "de", "def")
Output: 9

Two words are "abc" and "def".

Example 2

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: 0

Since no two words can be chosen without sharing letters, the result is 0.

Example 3

Input: @words = ("meet", "app", "code", "sky", "bold")
Output: 16

Two words are "meet" and "bold".

Example 4

Input: @words = ("a", "ab", "abc", "abcd", "efghi")
Output: 20

Two words are "abcd" and "efghi".

Example 5

Input: @words = ("xyz", "w", "abcdefg", "hij")
Output: 21

Two words are "abcdefg" and "hij".
=cut






use Test2::V0 -no_srand => 1;

is(words_length_product("a", "ab", "abc", "d", "de", "def"), 9, 'Example 1');
is(words_length_product("a", "aa", "aaa", "aaaa"), 0, 'Example 2');
is(words_length_product("meet", "app", "code", "sky", "bold"), 16, 'Example 3');
is(words_length_product("a", "ab", "abc", "abcd", "efghi"), 20, 'Example 4');
is(words_length_product("xyz", "w", "abcdefg", "hij"), 21, 'Example 5');
done_testing();

sub words_length_product
{
     my @words = @_;
     my ($max, $w1, $w2) = (0, '', '');
     for my $idx_1 ( 0 .. $#words - 1 )
     {
          my $word = $words[$idx_1];
          my $regex = join('|', split(//, $word));
          for my $idx_2 ( $idx_1 + 1 .. $#words )
          {
               my $candidate = $words[$idx_2];
               next if $candidate =~ /$regex/;
               my $product = length($word) * length($candidate);
               if ( $product > $max )
               {
                    $max = $product;
                    $w1 = $word;
                    $w2 = $candidate;
               }
          }
     }
     
     # print join(" ", $max, $w1, $w2), $/;
     return $max;
}
