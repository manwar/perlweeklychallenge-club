#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to return the smallest absent positive integer such that it is strictly greater than the average of all elements in the given array.
Example 1

Input: @arr = (1, 2, 4, 5, 6)
Output: 7

Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
We need the smallest positive integer absent from nums that is strictly greater than 3.6.
The positive integers greater than 3.6 are 4, 5, 6, 7, ....

4 is in the given array.
5 is in the given array.
6 is in the given array.
7 is not in.

Example 2

Input: @arr = (-5, -2, -1, 3)
Output: 1

Average: (-5 -2 -1 + 3) / 4 = -1.25
We need the smallest absent positive integer strictly greater than -1.25.
Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).

1 is positive and absent from the given array.

Example 3

Input: @arr = (1, 2, 3)
Output: 4

Average: (1 + 2 + 3) / 3 = 2.0
We need an integer strictly greater than 2.0.

3 is in the given array.
4 is not in.

Example 4

Input: @arr = (2, 3, 7, 8)
Output: 6

Average: (2 + 3 + 7 + 8) / 4 = 5.0
We need an integer strictly greater than 5.0.

6 is not in the given array.

Example 5

Input: @arr = (1, 1, 1, 10)
Output: 4

Average: (1 + 1 + 1 + 10) / 4 = 3.25
Positive integers strictly greater than 3.25: 4, 5, 6, ...

4 is not in the given array.

=cut


use List::Util qw(sum);
use Test2::V0 -no_srand => 1;
is(absent_smallest_positive_above_average(1, 2, 4, 5, 6), 7, 'Example 1');
is(absent_smallest_positive_above_average(-5, -2, -1, 3), 1, 'Example 2');
is(absent_smallest_positive_above_average(1, 2, 3), 4, 'Example 3');
is(absent_smallest_positive_above_average(2, 3, 7, 8), 6, 'Example 4');
is(absent_smallest_positive_above_average(1, 1, 1, 10), 4, 'Example 5');
done_testing();


sub absent_smallest_positive_above_average
{
     my @arr = @_;
     die "No numbers!" unless scalar(@arr);
     my $avg = sum(@arr) / scalar(@arr);
     my $candidate = $avg <= 0 ? 1 : int($avg) + 1; 
     while ( grep { $_ == $candidate } @arr )
     {
          $candidate++;
     }
     return $candidate;
}
