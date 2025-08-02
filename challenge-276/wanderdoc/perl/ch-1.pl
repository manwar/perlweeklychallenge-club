#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @hours.

Write a script to return the number of pairs that forms a complete day.

    A complete day is defined as a time duration that is an exact multiple of 24 hours.

Example 1

Input: @hours = (12, 12, 30, 24, 24)
Output: 2

Pair 1: (12, 12)
Pair 2: (24, 24)

Example 2

Input: @hours = (72, 48, 24, 5)
Output: 3

Pair 1: (72, 48)
Pair 2: (72, 24)
Pair 3: (48, 24)

Example 3

Input: @hours = (12, 18, 24)
Output: 0

=cut

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use Test2::V0;


is(complete_days(12, 12, 30, 24, 24), 2, 'Example 1');
is(complete_days(72, 48, 24, 5), 3, 'Example 2');
is(complete_days(12, 18, 24), 0, 'Example 3');
done_testing();

sub complete_days
{
     my @hours = @_;
     my $iter = combinations(\@hours, 2);
     my $counter = 0;
     while (my $p = $iter->next) 
     {
          if ( sum(@$p) % 24 == 0 )
          {
               $counter++;
          }
     }
     return $counter;
}