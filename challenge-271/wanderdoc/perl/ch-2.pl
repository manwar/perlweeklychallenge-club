#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.
Example 1

Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

0 = 0 one bits
1 = 1 one bits
2 = 1 one bits
4 = 1 one bits
8 = 1 one bits
3 = 2 one bits
5 = 2 one bits
6 = 2 one bits
7 = 3 one bits

Example 2

Input: @ints = (1024, 512, 256, 128, 64)
Output: (64, 128, 256, 512, 1024)

All integers in the given array have one 1-bits, so just sort them in ascending order.
=cut

use Test2::V0;

is(sort_by_1_bits(0, 1, 2, 3, 4, 5, 6, 7, 8), [0, 1, 2, 4, 8, 3, 5, 6, 7], 'Example 1');
is(sort_by_1_bits(1024, 512, 256, 128, 64), [64, 128, 256, 512, 1024], 'Example 2');
done_testing();



sub sort_by_1_bits
{
     return [sort { count_set_bits($a) <=> count_set_bits($b) || $a <=> $b } @_];
}



sub count_set_bits
{
     my $dec = $_[0];
     my $bit_string = sprintf ("%b", $dec);
     my $bit_count = $bit_string =~ tr/1/1/;
     return $bit_count;
}

