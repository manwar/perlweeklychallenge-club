#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.
Write a script to return the maximum between the number of positive and negative integers. Zero is neither positive nor negative.

Example 1

Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3

There are 3 positive integers.
There are 3 negative integers.
The maximum between 3 and 3 is 3.


Example 2

Input: @ints = (-2, -1, 0, 0, 1)
Output: 2

There are 1 positive integers.
There are 2 negative integers.
The maximum between 2 and 1 is 2.


Example 3

Input: @ints = (1, 2, 3, 4)
Output: 4

There are 4 positive integers.
There are 0 negative integers.
The maximum between 4 and 0 is 4.
=cut



use List::Util qw(max);
use Test2::V0 -no_srand => 1;

is(max_count(-3, -2, -1, 1, 2, 3), 3, 'Example 1');
is(max_count(-2, -1, 0, 0, 1), 2, 'Example 2');
is(max_count(1, 2, 3, 4), 4, 'Example 3');
done_testing();


sub max_count
{
     my @arr = @_;
     my $pos = my $neg = 0;
     for my $elm ( @arr )
     {
          if ($elm > 0) {$pos++;}
          elsif ($elm < 0 ) {$neg++;}
     }
     return max($pos, $neg);
}
