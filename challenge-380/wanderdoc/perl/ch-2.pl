#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to find the reverse degree of the given string.

    For each character, multiply its position in the reversed alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in the string. Sum these products for all characters in the string to get the reverse degree.

Example 1

Input: $str = "z"
Output: 1

Reverse alphabet value of "z" is 1.
Position 1: 1 x 1
Sum of product: 1

Example 2

Input: $str = "a"
Output: 26

Reverse alphabet value of "a" is 26.
Position 1: 1 x 26
Sum of product: 26

Example 3

Input: $str = "bbc"
Output: 147

Reverse alphabet value of "b" is 25 and "c" is 24.
Position 1: 1 x 25
Position 2: 2 x 25
Position 3: 3 x 24
Sum of product: 25 + 50 + 72 => 147

Example 4

Input: $str = "racecar"
Output: 560

Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
Position 1: 1 x 9
Position 2: 2 x 26
Position 3: 3 x 24
Position 4: 4 x 22
Position 5: 5 x 24
Position 6: 6 x 26
Position 7: 7 x 9
Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63

Example 5

Input: $str = "zyx"
Output: 14

Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
Position 1: 1 x 1
Position 2: 2 x 2
Position 3: 3 x 3
Sum of product: 1 + 4 + 9
=cut

use Test2::V0 -no_srand => 1;
is(sum_of_product("z"), 1, 'Example 1');
is(sum_of_product("a"), 26, 'Example 2');
is(sum_of_product("bbc"), 147, 'Example 3');
is(sum_of_product("racecar"), 560, 'Example 4');
is(sum_of_product("zyx"), 14, 'Example 5');
done_testing();


sub sum_of_product
{
     my $str = $_[0];
     my %letters;
     @letters{'a' .. 'z'} = reverse 1 .. 26;
     my $sum = 0;
     for my $idx ( 0 .. length($str) - 1 )
     {
          $sum += $letters{substr($str, $idx, 1)} * ($idx + 1);
     }
     return $sum;
}
