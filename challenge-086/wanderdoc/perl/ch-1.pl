#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers @N and an integer $A. Write a script to find find if there exists a pair of elements in the array whose difference is $A. Print 1 if exists otherwise 0.
Example 1: Input: @N = (10, 8, 12, 15, 5) and $A = 7 Output: 1 as 15 - 8 = 7
Example 2: Input: @N = (1, 5, 2, 9, 7) and $A = 6 Output: 1 as 7 - 1 = 6
Example 3: Input: @N = (10, 30, 20, 50, 40) and $A = 15 Output: 0
=cut






use Test::More;

sub pair_diff
{
     my ($aref, $num) = @_;
     @$aref = sort {$a <=> $b} @$aref;


     my $i = 0;

     my $j = 1;
     while ( $i <= $#$aref and $j <= $#$aref )
     {
          if ( $aref->[$j] - $aref->[$i] == $num )
          {
               return 1;
          }
          elsif ( $aref->[$j] - $aref->[$i] < $num  or $j == $i)
          {
               $j++;
          }



          else
          {
               $i++;
          }
     }
     return 0;
}


is(pair_diff([10,  8, 12, 15,  5],  7), 1, 'Example 1');
is(pair_diff([ 1,  5,  2,  9,  7],  6), 1, 'Example 2');
is(pair_diff([10, 30, 20, 50, 40], 15), 0, 'Example 3');
done_testing();