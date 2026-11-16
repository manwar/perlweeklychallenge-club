#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer.

Write a script that generates a sequence of integers from 1 to given positive integer, filtering out any numbers that contain repeating digits (e.g., 11, 99, 100, and 101 are excluded) and return the biggest jump.
Example 1

Input: $int = 20
Output: 2

Biggest jump between 10 and 12.

Example 2

Input: $int = 110
Output: 4

Biggest jump between 98 and 102.

Example 3

Input: $int = 500
Output: 11

Biggest jump between:
a) 109 and 120 => 11
b) 219 and 230 => 11
c) 329 and 340 => 11
d) 439 and 450 => 11

Example 4

Input: $int = 2026
Output: 105

Biggest jump between 1098 and 1203.

Example 5

Input: $int = 10000
Output: 105

The largest gap is 105, between 1098 and 1203. And again between 8796 and 8901.

=cut

# use List::Util qw(max);
use Test2::V0 -no_srand => 1;

is(largest_interval(20), 2, 'Example 1');
is(largest_interval(110), 4, 'Example 2');
is(largest_interval(500), 11, 'Example 3');
is(largest_interval(2026), 105, 'Example 4');
is(largest_interval(10000), 105, 'Example 5');
done_testing();

sub largest_interval
{
     my $int = $_[0];
     my ($first, $last) = (1, 1);
     # my %intervals;
     my ($max, $num) = (0, 0); 
     while ( $num <= $int )
     {
          $num++;
          next if $num =~ /(?<doubles>[0-9])[0-9]*\g{doubles}/;
          if ( $num - $last == 1 )
          {
               $last = $num;
          }
          else
          {
               # push @{$intervals{$num - $last}}, [$last, $num] if ($last != $first);
               $max = $max > $num - $last ? $max : $num - $last;
               $first = $last = $num;
          }
     }
     # return max keys %intervals;
     return $max;
}
