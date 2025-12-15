#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the given array.
Example 1

Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250

Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000

Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

Input: @ints = (2500, 2500, 2500, 2500)
Output: 0

Min: 2500
Max: 2500
Avg: 0

Example 4
Input: @ints = (2000)
Output: 0


Min: 2000
Max: 2000
Avg: 0

Example 5

Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500

Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500
=cut


use List::Util qw(min max sum);
use Test2::V0 -no_srand => 1;

is(modified_average(8000, 5000, 6000, 2000, 3000, 7000), 5250, 'Example 1');
is(modified_average(100_000, 80_000, 110_000, 90_000), 95_000, 'Example 2');
is(modified_average(2500, 2500, 2500, 2500), 0, 'Example 3');
is(modified_average(2000), 0, 'Example 4');
is(modified_average(1000, 2000, 3000, 4000, 5000, 6000), 3500, 'Example 5');
done_testing();



sub modified_average
{
     my @arr = @_;
     my $min = min(@arr);
     my $max = max(@arr);
     @arr = grep {$_ != $min and $_ != $max} @arr;
     return average(@arr);
}

sub average
{
     my @arr = @_;
     my $num = scalar @arr;
     return 0 unless $num > 0; # die "No values!" unless $num > 0;
     return 
          sprintf("%.0f", # or whatever.
          sum(@arr)/$num);
}
