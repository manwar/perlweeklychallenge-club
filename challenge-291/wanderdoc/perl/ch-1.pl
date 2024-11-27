#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst all the possible ones.

    A middle index is an index where ints[0] + ints[1] + ... + ints[MI-1] == ints[MI+1] + ints[MI+2] + ... + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly, 
if MI == ints.length - 1, the right side sum is considered to be 0.

Return the leftmost MI that satisfies the condition, or -1 if there is no such index.
Example 1

Input: @ints = (2, 3, -1, 8, 4)
Output: 3

The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4

Example 2

Input: @ints = (1, -1, 4)
Output: 2

The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0

Example 3

Input: @ints = (2, 5)
Output: -1

There is no valid MI.
=cut


use List::Util qw(sum);
use Test2::V0;

is(middle_index(2, 3, -1, 8, 4), 3, 'Example 1');
is(middle_index(1, -1, 4), 2, 'Example 2');
is(middle_index(2, 5), -1, 'Example 3');
done_testing();


sub middle_index
{
     my @arr = @_;
     for my $idx ( 0 .. $#arr )
     {
          my ($sum_left, $sum_right);
          if ( $idx == 0 )        { $sum_left = 0; $sum_right = sum(@arr[1 .. $#arr]); }
          elsif ( $idx == $#arr ) { $sum_left = sum(@arr[0 .. $#arr - 1]); $sum_right = 0; }
          else
          {
               $sum_left  = sum(@arr[0 .. $idx - 1]);
               $sum_right = sum(@arr[$idx + 1 .. $#arr]);
          }
          if ( $sum_left == $sum_right ) { return $idx; }
     }
     return -1;
}