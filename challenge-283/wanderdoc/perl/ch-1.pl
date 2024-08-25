#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints, where every elements appears more than once except one element.

Write a script to find the one element that appears exactly one time.
Example 1

Input: @ints = (3, 3, 1)
Output: 1

Example 2

Input: @ints = (3, 2, 4, 2, 4)
Output: 3

Example 3

Input: @ints = (1)
Output: 1

Example 4

Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3


=cut

use Test2::V0;

is(find_unique(3, 3, 1), 1, 'Example 1');
is(find_unique(3, 2, 4, 2, 4), 3, 'Example 2');
is(find_unique(1), 1, 'Example 3');
is(find_unique(4, 3, 1, 1, 1, 4), 3, 'Example 4');
is(find_unique(1, 2, 3, 4, 5), "More appear exactly one time", 'Example 5');
is(find_unique(1, 1, 2, 2, 3, 3), "Not found", 'Example 6');
done_testing();


sub find_unique
{
      my @arr = @_;
      my %freq;
      $freq{$_}++ for @arr;
      my @output = grep { $freq{$_} == 1 } keys %freq;
      if ((scalar @output) == 1)
      {
          return $output[0];
      }
      elsif ((scalar @output) == 0)
      {
          return 'Not found';
      }
      else
      {
          return "More appear exactly one time";
      }
}