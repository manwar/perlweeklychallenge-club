#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two integers, $base and $limit.

Write a script to find all Armstrong numbers in base $base that are less than $limit.

    If raising each of the digits of a nonnegative integer to the power of the total number of digits, then taking the sum, equals the original number, it is an Armstrong number.

Example 1

Input: $base = 10, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)

Example 2

Input: $base = 7, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)

Example 3

Input: $base = 16, $limit = 1000
Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)
=cut

use List::Util qw(sum);
use Math::Int2Base qw( int2base base2int );
use Test2::V0 -no_srand => 1;

is([armstrong_number(10, 1000)], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], 'Example 1');
is([armstrong_number(7, 1000)], [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], 'Example 2');
is([armstrong_number(16, 1000)], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], 'Example 3');

done_testing();





sub armstrong_number
{
     my ($base, $limit) = @_;
     my @output = (0 .. $base - 1);
     for my $num ( $base .. $limit )
     {
          my $num_base = int2base($num, $base);

          my $length = length($num_base);
          my $test_sum = sum(map { base2int($_, 16) ** $length } 
                         split(//, $num_base));
          if ( $test_sum == $num )
          {
               push @output, $num;
          }
     }

     return @output;
}
