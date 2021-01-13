#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers @A.
Write a script to create an array that represents the smaller element to the left of each corresponding index. If none found then use 0.
Example 1 Input: @A = (7, 8, 3, 12, 10) Output: (0, 7, 0, 3, 3)
Example 2 Input: @A = (4, 6, 5) Output: (0, 4, 4)
=cut






use List::Util qw(min);
use Test::More;


sub smallest_neighbour
{
     my @arr = @_;
     my @small;
     $small[0] = 0;

     for my $i ( 1 .. $#arr )
     {
          push @small, min(@arr[0..$i-1]) < $arr[$i] ? min(@arr[0..$i-1]) : 0;
     }
     return @small;
}


is_deeply([smallest_neighbour(7,8,3,12,10)], [0,7,0,3,3], 'Example 1');
is_deeply([smallest_neighbour(4,6,5)],       [0,4,4],     'Example 2');
done_testing();