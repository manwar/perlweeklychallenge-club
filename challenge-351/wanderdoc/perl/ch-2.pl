#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of numbers.
Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false.

    A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.


Example 1

Input: @num = (1, 3, 5, 7, 9)
Output: true

Already AP with common difference 2.

Example 2
Input: @num = (9, 1, 7, 5, 3)
Output: true

The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.

Example 3

Input: @num = (1, 2, 4, 8, 16)
Output: false

This is geometric progression and not arithmetic progression.


Example 4

Input: @num = (5, -1, 3, 1, -3)
Output: true

The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.


Example 5

Input: @num = (1.5, 3, 0, 4.5, 6)
Output: true

The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
=cut




use List::MoreUtils qw(slide); # Strawberry 5.40.0
use constant {true => 1, false => 0};
use Test2::V0 -no_srand => 1;




is(is_arithmetic_progression(1, 3, 5, 7, 9), true, 'Example 1');
is(is_arithmetic_progression(9, 1, 7, 5, 3), true, 'Example 2');
is(is_arithmetic_progression(1, 2, 4, 8, 16), false, 'Example 3');
is(is_arithmetic_progression(5, -1, 3, 1, -3), true, 'Example 4');
is(is_arithmetic_progression(1.5, 3, 0, 4.5, 6), true, 'Example 5');
done_testing();

sub is_arithmetic_progression
{
     my @arr = @_;
     my %diffs = 
          map { $_ => undef }
          slide { $b - $a }
          sort { $a <=> $b } @arr;
     return 1 == scalar keys %diffs ? true : false;
}
