#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to find the number of elements that have both a strictly smaller and greater element in the given array.
Example 1

Input: @int = (2,4)
Output: 0

Not enough elements in the array.

Example 2

Input: @int = (1, 1, 1, 1)
Output: 0

Example 3

Input: @int = (1, 1, 4, 8, 12, 12)
Output: 2

The elements are 4 and 8.

Example 4

Input: @int = (3, 6, 6, 9)
Output: 2

Both instances of 6.

Example 5

Input: @int = (0, -5, 10, -2, 4)
Output: 3

The elements are 0, -2, and 4.
=cut





use Test2::V0 -no_srand => 1;


is(smaller_greater(2, 4), 0, 'Example 1');
is(smaller_greater(1, 1, 1, 1), 0, 'Example 2');
is(smaller_greater(1, 1, 4, 8, 12, 12), 2, 'Example 3');
is(smaller_greater(3, 6, 6, 9), 2, 'Example 4');
is(smaller_greater(0, -5, 10, -2, 4), 3, 'Example 5');
done_testing();

sub smaller_greater
{
     my @arr = @_;
     return 0 if scalar(@arr) < 3;
     @arr = sort {$a <=> $b} @arr;
     my @output;
     for my $idx ( 1 .. $#arr - 1 )
     {
          my ($smaller, $greater) = (0, 0);
          my $idx_min = $idx - 1;

          MIN: while ( $idx_min >= 0)
          {
               if ( $arr[$idx_min] < $arr[$idx] )
               {
                    $smaller = 1;
                    last MIN;
               }
               else
               {
                    $idx_min--;
               }
          }
          my $idx_max = $idx + 1;

          MAX: while ( $idx_max <= $#arr )
          {
               if ( $arr[$idx] < $arr[$idx_max] )
               {
                    $greater = 1;
                    last;
               }
               else
               {
                    $idx_max++;
               }
          }

          if ( $smaller == 1 and $greater == 1 )
          {
               push @output, $arr[$idx];
          }
     }
     return scalar @output;
}
