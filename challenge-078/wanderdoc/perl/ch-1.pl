#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array @A containing distinct integers. Write a script to find all leader elements in the array @A. Print (0) if none found. An element is leader if it is greater than all the elements to its right side.

Example 1: Input: @A = (9, 10, 7, 5, 6, 1) Output: (10, 7, 6, 1)
Example 2: Input: @A = (3, 4, 5) Output: (5)
=cut




use Test::More;



sub find_leaders
{
     my @arr = @_;
     return @arr if scalar @arr == 1;
     
     my @leaders;
     unshift @leaders, pop @arr;

     for my $element ( reverse @arr )
     {
          if ( $element > $leaders[0] )
          {
               unshift @leaders, $element;
          }
     }
     return @leaders;
}





is_deeply([find_leaders(9, 10, 7, 5, 6, 1)], [(10, 7, 6, 1)], 'Example 1');
is_deeply([find_leaders(3, 4, 5)],           [(5)],           'Example 2');
done_testing();