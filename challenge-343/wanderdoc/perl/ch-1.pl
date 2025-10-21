#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of numbers.
Find the number that is closest to zero and return its distance to zero.

Example 1

Input: @nums = (4, 2, -1, 3, -2)
Output: 1

Values closest to 0: -1 and 2 (distance = 1 and 2)


Example 2

Input: @nums = (-5, 5, -3, 3, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)


Example 3

Input: @ums = (7, -3, 0, 2, -8)
Output: 0

Values closest to 0: 0 (distance = 0)
Exact zero wins regardless of other close values.


Example 4

Input: @nums = (-2, -5, -1, -8)
Output: 1
Values closest to 0: -1 and -2 (distance = 1 and 2)


Example 5

Input: @nums = (-2, 2, -4, 4, -1, 1)
Output: 1

Values closest to 0: -1 and 1 (distance = 1)
=cut


use List::Util qw(first);
use Test2::V0 -no_srand => 1;

is(closest_to_zero(4, 2, -1, 3, -2), 1, 'Example 1');
is(closest_to_zero(-5, 5, -3, 3, -1, 1), 1, 'Example 2');
is(closest_to_zero(7, -3, 0, 2, -8), 0, 'Example 3');
is(closest_to_zero(-2, -5, -1, -8), 1, 'Example 4');
is(closest_to_zero(-2, 2, -4, 4, -1, 1), 1, 'Example 5');
done_testing();

sub closest_to_zero
{
     my @nums = @_;
     if ( defined first { $_ == 0 } @nums )
     {
          return 0;
     }
     my $min = ~0+1;
     for my $num ( @nums )
     {
          $min = $min < abs($num) ? $min : abs($num);
     }
     return $min;
     
}
