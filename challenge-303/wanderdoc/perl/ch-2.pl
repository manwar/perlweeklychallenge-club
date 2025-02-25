#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to return the maximum number of points you can earn by applying the following operation some number of times.

Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.

Example 1

Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.

Example 2

Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.
=cut

use Test2::V0;


is(delete_and_earn(3, 4, 2), 6, 'Example 1');
is(delete_and_earn(2, 2, 3, 3, 3, 4), 9, 'Example 2');
done_testing();



sub delete_and_earn 
{
     my @arr = @_;
     my %points;
     $points{$_} += $_ for @arr;
     my @stack = ([0, [@arr]]);
     my $max = 0;
     while (@stack) 
     {
          my $state = pop @stack;
          my ($sum, $rest_aref) = @$state;
          if (scalar @$rest_aref == 0) 
          {
               $max = $sum if $sum > $max;
               next;
          }

          for my $idx (0 .. $#$rest_aref) 
          {
               my @this_arr = @$rest_aref;
               my $this_num = $this_arr[$idx];
               my $this_sum = $points{$this_num};

               splice(@this_arr, $idx, 1); 
               my @new_arr = grep 
                    { $_ != $this_num and 
                      $_ != $this_num - 1 and 
                      $_ != $this_num + 1 } @this_arr;

               my $new_sum = $sum + $this_sum;
               $max = $new_sum if $new_sum > $max;
               push @stack, [$new_sum, [@new_arr]];
          }
     }
     return $max;
}