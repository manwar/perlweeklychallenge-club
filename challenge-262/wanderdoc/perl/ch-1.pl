#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints. Write a script to return the maximum number of either positive or negative integers in the given array.
Example 1
Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
Output: 4
Count of positive integers: 4
Count of negative integers: 3
Maximum of count of positive and negative integers: 4

Example 2
Input: @ints = (-1, -2, -3, 1)
Output: 3
Count of positive integers: 1
Count of negative integers: 3
Maximum of count of positive and negative integers: 3

Example 3
Input: @ints = (1,2)
Output: 2
Count of positive integers: 2
Count of negative integers: 0
Maximum of count of positive and negative integers: 2
=cut

use List::Util qw(max);
use Test2::V0;

is(max_pos_neg(-3, 1, 2, -1, 3, -2, 4), 4, 'Example 1');
is(max_pos_neg(-1, -2, -3, 1), 3, 'Example 2');
is(max_pos_neg(1, 2), 2, 'Example 3');
done_testing();


sub max_pos_neg
{
     my @arr = @_;
     my $pos = my $neg = '';
     for my $int ( @arr )
     {
          if    ( $int > 0 ) { vec($pos, $int, 1) = 1;     }
          elsif ( $int < 0 ) { vec($neg, abs($int), 1) = 1;}
     }
     return max (unpack("%32b*", $pos), unpack("%32b*", $neg));
}