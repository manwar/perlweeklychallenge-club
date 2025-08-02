#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of @ints.

Write a script to find the sign of product of all integers in the given array. The sign is 1 if the product is positive, -1 if the product is negative and 0 if product is zero.
Example 1

Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
Output: 1

The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

Example 2

Input: @ints = (1, 2, 0, -2, -1)
Output: 0

The product 1 x 2 x 0 x -2 x -1 => 0

Example 3

Input: @ints = (-1, -1, 1, -1, 2)
Output: -1

The product -1 x -1 x 1 x -1 x 2 => -2 < 0
=cut


use Test2::V0;

is(product_sign(-1, -2, -3, -4, 3, 2, 1), 1, 'Example 1');
is(product_sign(1, 2, 0, -2, -1), 0, 'Example 2');
is(product_sign(-1, -1, 1, -1, 2), -1, 'Example 3');
done_testing();



sub product_sign
{
     my @arr = @_;
     my $sign = 1;
     for my $elm ( @arr )
     {
          return 0 if 0 == $elm;
          if    ($elm  > 0 and $sign > 0) { $sign =  1; }
          elsif ($elm  > 0 and $sign < 0) { $sign = -1; }
          elsif ($elm  < 0 and $sign > 0) { $sign = -1; }
          elsif ($elm  < 0 and $sign < 0) { $sign =  1; }
          else {print "Debug: \$sign = $sign and \$elm = $elm$/";}
     }
     return $sign;
}