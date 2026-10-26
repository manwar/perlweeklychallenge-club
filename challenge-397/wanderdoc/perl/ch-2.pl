#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integer.

Write a script to sort the given array in ascending order based on the binary reflection of each element. If two different numbers have the same binary reflection, the smaller original number should appear first.
Example 1

Input: @arr = (3, 6, 12)
Output: (3, 6, 12)

Decimal 3  = Binary 11 -> reverse is also same 11 = Decimal 3
Decimal 6  = Binary 110 -> reverse 011 = Decimal 3
Decimal 12 = Binary 1100 -> 0011 = Decimal 3

All three elements have the same binary reflection (3).
Since they tie, they are sorted by their original values in ascending order: (3, 6, 12).

Example 2

Input: @arr = (1, 2, 4, 8)
Output: (1, 2, 4, 8)

Decimal 1 = Binary 1 -> reverse is also same 1 = Decimal 1
Decimal 2 = Binary 10 -> reverse is 01 = Decimal 1
Decimal 4 = Binary 100 -> reverse 001 = Decimal 1
Decimal 8 = Binary 1000 -> reverse is 0001 = Decimal 1

All elements reflect to 1. Tie-breaking by original value yields (1, 2, 4, 8).

Example 3

Input: @arr = (7, 8, 9, 10)
Output: (8, 10, 7, 9)

Decimal 8  = Binary 1000 -> reverse 0001 = Decimal 1
Decimal 9  = Binary 1001 -> reverse 1001 = Decimal 9
Decimal 10 = Binary 1010 -> reverse 0101 = Decimal 5
Decimal 7  = Binary 111 -> reverse 111 = Decimal 7

Binary reflections:
8  -> 1
9  -> 9
10 -> 5
7  -> 7

Sorting by reflection values (1, 5, 7, 9) gives original elements (8, 10, 7, 9).

Example 4

Input: @arr = (5, 9, 15, 17)
Output: (5, 9, 15, 17)

Decimal 5  = Binary 101 -> reverse 101 = Decimal 5
Decimal 9  = Binary 1001 -> reverse 1001 = Decimal 9
Decimal 15 = Binary 1111 -> reverse 1111 = Decimal 15
Decimal 17 = Binary 10001 -> reverse 10001 = Decimal 17

All numbers are binary palindromes, so their reflections match their original decimal values (5, 9, 15, 17), leaving the array order unchanged.

Example 5

Input: @arr = (11, 13, 14, 19)
Output: (14, 13, 11, 19)

Decimal 11 = Binary 1011 -> reverse 1101 = Decimal 13
Decimal 13 = Binary 1101 -> reverse 1011 = Decimal 11
Decimal 14 = Binary 1110 -> reverse 0111 = Decimal 7
Decimal 19 = Binary 10011 -> reverse 11001 = Decimal 25

Reflections:
14 -> 7
13 -> 11
11 -> 13
19 -> 25

Sorted by reflection values (7, 11, 13, 25) yields (14, 13, 11, 19).

=cut





use Test2::V0 -no_srand => 1;
is([binary_reflection_sort(3, 6, 12)], [3, 6, 12], 'Example 1');
is([binary_reflection_sort(1, 2, 4, 8)], [1, 2, 4, 8], 'Example 2');
is([binary_reflection_sort(7, 8, 9, 10)], [8, 10, 7, 9], 'Example 3');
is([binary_reflection_sort(5, 9, 15, 17)], [5, 9, 15, 17], 'Example 4');
is([binary_reflection_sort(11, 13, 14, 19)], [14, 13, 11, 19], 'Example 5');
done_testing();


sub binary_reflection_sort
{
     my @arr = @_;
     return sort { binary_reflection($a) <=> binary_reflection($b) 
          || $a <=> $b } @arr;
}


sub binary_reflection
{
     my $str = $_[0];
     my $binary = sprintf("%b", $str);
     my $binary_reflection = reverse $binary;
     return oct("0b" . $binary_reflection);
}
