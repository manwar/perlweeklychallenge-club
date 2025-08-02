#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of distinct integers.
Write a script to find all pairs of elements with minimum absolute difference (MAD) of any two elements.

Example 1

Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

The minimum absolute difference is 1.
Pairs with MAD: [1,2], [2,3], [3,4]


Example 2

Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]


Example 3

Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]


=cut


use Test2::V0 -no_srand => 1;

is([min_abs_diff(4, 1, 2, 3)], [[1,2], [2,3], [3,4]], 'Example 1');
is([min_abs_diff(1, 3, 7, 11, 15)], [[1,3]], 'Example 2');
is([min_abs_diff(1, 5, 3, 8)], [[1,3], [3,5]], 'Example 3');
done_testing();



sub min_abs_diff
{
     my @arr = @_;
     @arr = sort { $a <=> $b } @arr;
     my @output; 
     my $min_diff = ~0+1;
     for my $idx ( 0 .. $#arr-1 )
     {
          if ( ($arr[$idx+1] - $arr[$idx]) < $min_diff )
          {
               @output = ();
               push @output, [$arr[$idx], $arr[$idx+1]];
               $min_diff = $arr[$idx+1] - $arr[$idx]
          }
          elsif (($arr[$idx+1] - $arr[$idx]) == $min_diff)
          {
               push @output, [$arr[$idx], $arr[$idx+1]];
          }
     }
     return @output;
}
