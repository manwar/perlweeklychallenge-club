#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is calculate by removing the minimum and the maximum, then average of the two.

Example 1

Input: @nums = (1, 2, 4, 3, 5, 6)
Output: 1

Step 1: Min = 1, Max = 6, Avg = 3.5
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5

The count of distinct average is 1.


Example 2

Input: @nums = (0, 2, 4, 8, 3, 5)
Output: 2

Step 1: Min = 0, Max = 8, Avg = 4
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5

The count of distinct average is 2.


Example 3

Input: @nums = (7, 3, 1, 0, 5, 9)
Output: 2

Step 1: Min = 0, Max = 9, Avg = 4.5
Step 2: Min = 1, Max = 7, Avg = 4
Step 3: Min = 3, Max = 5, Avg = 4

The count of distinct average is 2.
=cut


use List::Util qw(sum);
use Test2::V0 -no_srand => 1;


is(distinct_average(1, 2, 4, 3, 5, 6), 1, 'Example 1');
is(distinct_average(0, 2, 4, 8, 3, 5), 2, 'Example 2');
is(distinct_average(7, 3, 1, 0, 5, 9), 2, 'Example 3');
done_testing();


sub distinct_average
{
     my @arr = sort { $a <=> $b } @_;
     my %averages;
     while (scalar(@arr))
     {
          my $avg = sum(@arr)/scalar(@arr);
          $averages{$avg} = undef;
          shift @arr;
          pop @arr if ( scalar @arr );
     }
     return scalar keys %averages;
}
