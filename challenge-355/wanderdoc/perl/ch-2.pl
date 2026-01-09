#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.
Write a script to return true if the given array is a valid mountain array.

An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Output: false

Example 2

Input: @ints = (0, 2, 4, 6, 4, 2, 0)
Output: true


Example 3

Input: @ints = (5, 4, 3, 2, 1)
Output: false



Example 4

Input: @ints = (1, 3, 5, 5, 4, 2)
Output: false



Example 5

Input: @ints = (1, 3, 2)
Output: true
=cut

use constant {true => 1, false => 0};
use Test2::V0 -no_srand => 1;

is(mountain_array(1, 2, 3, 4, 5), false, 'Example 1');
is(mountain_array(0, 2, 4, 6, 4, 2, 0), true, 'Example 2');
is(mountain_array(5, 4, 3, 2, 1), false, 'Example 3');
is(mountain_array(1, 3, 5, 5, 4, 2), false, 'Example 4');
is(mountain_array(1, 3, 2), true, 'Example 5');
is(mountain_array(1, 3, 5, 4, 3, 2, 3, 5, 2), false, 'Example 6');
done_testing();


sub mountain_array
{
     my @arr = @_;
     my $left = my $right = 0;
     for my $idx (1 .. $#arr)
     {
          return false if ($arr[$idx - 1] == $arr[$idx]);
          
          if ($arr[$idx - 1] < $arr[$idx] )
          {
               if ( $left == 0 )
               {
                    $left = 1;
               }
               elsif ($right == 1)
               {
                    return false;
               }
          }
          elsif ( $arr[$idx - 1] > $arr[$idx] )
          {
               if ( $right == 0 )
               {
                    $right = 1;
               }
               elsif ($left == 0)
               {
                    return false;
               }
          }
     }
     return false if ( $left * $right == 0 );
     return true;
}
