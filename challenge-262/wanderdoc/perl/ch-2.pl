#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints and an integer $k. Write a script to return the number of pairs (i, j) where
a) 0 <= i < j < size of @ints
b) ints[i] == ints[j]
c) i x j is divisible by k
Example 1 Input: @ints = (3,1,2,2,2,1,3) and $k = 2 Output: 4
(0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
(2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
(2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
(3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2
Example 2 Input: @ints = (1,2,3) and $k = 1 Output: 0
=cut

use Test2::V0;

is(count_equal_divisible([3,1,2,2,2,1,3], 2), 4, 'Example 1');
is(count_equal_divisible([1,2,3], 1), 0, 'Example 2');
done_testing();


sub count_equal_divisible
{
     my ($aref, $k) = @_;
     my @output;
     for my $i ( 0 .. $#$aref - 1 )
     {
          for my $j ( $i + 1 .. $#$aref )
          {
               if ( ($aref->[$i] == $aref->[$j]) and 
                    (($i * $j) % $k == 0) )
               {
                    push @output, [$i, $j];
               }
          }
     }

     return scalar @output; # @output;
}