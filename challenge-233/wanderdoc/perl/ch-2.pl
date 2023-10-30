#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers. Write a script to sort the given array in increasing order based on the frequency of the values. If multiple values have the same frequency then sort them in decreasing order.
Example 1 Input: @ints = (1,1,2,2,2,3) Ouput: (3,1,1,2,2,2)
'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3

Example 2 Input: @ints = (2,3,1,3,2) Ouput: (1,3,3,2,2)

'2' and '3' both have a frequency of 2, so they are sorted in decreasing order.

Example 3 Input: @ints = (-1,1,-6,4,5,-6,1,4,1) Ouput: (5,-1,4,4,-6,-6,1,1,1)
=cut

use Test2::V0;

sub frequency_sort
{
     my @arr = @_;
     my %freq;
     $freq{$_}++ for @arr;
     @arr = sort { $freq{$a} <=> $freq{$b} || $b <=> $a } @arr;
     return @arr;
}

is([frequency_sort(1,1,2,2,2,3)], [3,1,1,2,2,2], 'Example 1');
is([frequency_sort(2,3,1,3,2)], [1,3,3,2,2], 'Example 2');
is([frequency_sort(-1,1,-6,4,5,-6,1,4,1)], [5,-1,4,4,-6,-6,1,1,1], 'Example 3');
done_testing();