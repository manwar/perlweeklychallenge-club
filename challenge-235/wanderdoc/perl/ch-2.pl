#!perl
use strict;
use warnings FATAL=> qw(all);

=prompt
You are given an array of integers. Write a script to duplicate each occurrence of ZERO in the given array and shift the remaining to the right but make sure the size of array remain the same.
Example 1 Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0) Output: (1, 0, 0, 2, 3, 0, 0, 4)
Example 2 Input: @ints = (1, 2, 3) Output: (1, 2, 3)
Example 3 Input: @ints = (0, 3, 0, 4, 5) Output: (0, 0, 3, 0, 0)
=cut






use Test2::V0;

sub duplicate_zeros
{
     my @arr = @_;
     my $max_idx = $#arr;
     my @output;
     for my $i ( 0 .. $max_idx )
     {
          push @output, $arr[$i];
          if ( $arr[$i] == 0 )
          {
               push @output, 0;
          }
          if ( $#output > $max_idx )
          {
               return @output[0 .. $max_idx];
          }
     }
     return @output;
}



is([duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0)], [(1, 0, 0, 2, 3, 0, 0, 4)], 'Example 1');
is([duplicate_zeros(1, 2, 3)], [(1, 2, 3)], 'Example 2');
is([duplicate_zeros(0, 3, 0, 4, 5)], [(0, 0, 3, 0, 0)], 'Example 3');
done_testing();

