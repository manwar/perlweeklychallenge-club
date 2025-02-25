#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an equal number of 0 and 1.
Example 1

Input: @binary = (1, 0)
Output: 2

(1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

Example 2

Input: @binary = (0, 1, 0)
Output: 2

(1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 and 1.

Example 3

Input: @binary = (0, 0, 0, 0, 0)
Output: 0

Example 4

Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4

=cut

use List::Util qw(sum max);
use Test2::V0 -no_srand => 1;


is(contiguous_array(0, 1), 2, 'Example 1');
is(contiguous_array(0, 1, 0), 2, 'Example 2');
is(contiguous_array(0, 0, 0, 0, 0), 0, 'Example 3');
is(contiguous_array(0, 1, 0, 0, 1, 0), 4, 'Example 4');
is(contiguous_array(1, 0, 1, 0, 1, 0, 0, 1, 1, 0), 10, 'Example 5');
done_testing();



sub contiguous_array 
{
     my @arr = @_;
     return 0 if scalar @arr < 2;

     @arr = map { $_ == 0 ? -1 : $_ } @arr; # Simplifies calculations.
     my $cum_sum = 0;
     my $max_length = 0;
     my %tracking = ( 0 => -1 );
     for my $idx (0 .. $#arr) 
     {
          $cum_sum += $arr[$idx];
          if (exists $tracking{$cum_sum}) 
          {
               my $subarray_length = $idx - $tracking{$cum_sum};
               $max_length = max($max_length, $subarray_length);
          } 
          else 
          {
               $tracking{$cum_sum} = $idx;
          }
     }
     return $max_length;
}