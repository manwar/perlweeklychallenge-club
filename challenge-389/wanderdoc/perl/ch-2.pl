#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers. Write a script to find the length of the longest contiguous subarray where the numbers alternate between strictly increasing and strictly decreasing (a ZigZag pattern).

    A sequence of numbers A = [ a 0 , a 1 , . . . , a k ] with length $k >= 1 is considered a ZigZag sequence if every adjacent pair alternates direction:

a_0 < a_1 > a_2 < a_3 > ...
OR
a_0 > a_1 < a_2 > a_3 < ...

NOTE: A single element (length 1) or any two distinct elements (length 2) are automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5) break the pattern.
Example 1

Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
Output: 5

ZigZag subarray: (4, 2, 10, 7, 8)

Example 2

Input: @nums = (1, 7, 4, 9, 2, 5)
Output: 6

ZigZag subarray: (1, 7, 4, 9, 2, 5)

Example 3

Input: @nums = (1, 2, 3, 4, 5)
Output: 2

ZigZag subarray: (1, 2)

Example 4

Input: @nums = (4, 4, 4)
Output: 1

Example 5

Input: @nums = (10, 20, 15, 12, 18)
Output: 3

ZigZag subarray: (10, 20, 15)

=cut

use Test2::V0 -no_srand => 1;

is(zigzag(9, 4, 2, 10, 7, 8, 8, 1, 9), 5, 'Example 1');
is(zigzag(1, 7, 4, 9, 2, 5), 6, 'Example 2');
is(zigzag(1, 2, 3, 4, 5), 2, 'Example 3');
is(zigzag(4, 4, 4), 1, 'Example 4');
is(zigzag(10, 20, 15, 12, 18), 3, 'Example 5');
done_testing();

sub zigzag
{
     my @arr = @_;
     my $flag = 0;
     my $start = my $end = 0;
     my @output;
     for my $idx ( 1 .. $#arr )
     {
          if ( $arr[$idx] > $arr[$idx - 1] )
          {
               if ( $flag == 0 or $flag == -1)
               {
                    $flag = 1;
                    $end = $idx;
               }
               else
               {
                    $end = $idx;
                    push @output, [$start, $end - 1];
                    $start = $idx - 1;
               }
          }
          elsif ( $arr[$idx] < $arr[$idx - 1] )
          {
               if ( $flag == 0 or $flag == 1)
               {
                    $flag = -1;
                    $end = $idx;
               }
               else
               {
                    $end = $idx;
                    push @output, [$start, $end - 1];
                    $start = $idx - 1;
               }
          }
          elsif( $arr[$idx] == $arr[$idx - 1])
          {
                    $end = $idx;
                    push @output, [$start, $end - 1];
                    $start = $idx;
          }
          
     }
     push @output, [$start, $end];
     @output = sort { $b <=> $a } map { $_->[1] - $_->[0] + 1} @output;
     return $output[0];
}
