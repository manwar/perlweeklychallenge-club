#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive numbers @N. Write a script to represent it as Histogram Chart and find out how much water it can trap.
Example 1: Input: @N = (2, 1, 4, 1, 2, 5)
Looking at the above histogram, we can see, it can trap 1 unit of rain water between 1st and 3rd column. Similary it can trap 5 units of rain water betweem 3rd and last column. Therefore your script should print 6.

Example 2
Input: @N = (3, 1, 3, 1, 1, 5)
Looking at the above histogram, we can see, it can trap 2 units of rain water between 1st and 3rd column. Also it can trap 4 units of rain water between 3rd and last column.

Therefore your script should print 6.
=cut

use List::Util qw(min max);

sub print_histogram # Challenge 075.
{
     my @arr = @_;
     my $max = max(@arr);
     my $offset = length($max);
     for my $high ( reverse 1 .. $max )
     {

          my @hist = map {$_ >= $high ? '#' : ' '} @arr;
          print $high, ' ' x $offset, join(' ', @hist), $/;
     }

     my @underl = map '_', @arr, $max;
     print join(' ', @underl), $/;
     print ' ' x ($offset + 1),  join(' ', @arr)   , $/;
}

sub estimate_water
{
     my @arr = @_;


     my @left;
     my @right;
     my $volume = 0;

     $left[0] = $arr[0];
     for my $idx ( 1 .. $#arr )
     {
          $left[$idx] = max($left[$idx - 1], $arr[$idx]);

     }

     $right[$#arr] = $arr[$#arr];
     for my $idx ( reverse 0 .. $#arr - 1 )
     {
          $right[$idx] = max($right[$idx + 1], $arr[$idx]);
     }


     for my $idx ( 0 .. $#arr )
     {
          $volume += min($left[$idx], $right[$idx]) - $arr[$idx];
     }

     return $volume;
}


print_histogram(2, 1, 4, 1, 2, 5);
print estimate_water(2, 1, 4, 1, 2, 5), $/; # 6

print_histogram(3, 1, 3, 1, 1, 5);
print estimate_water(3, 1, 3, 1, 1, 5), $/; # 6