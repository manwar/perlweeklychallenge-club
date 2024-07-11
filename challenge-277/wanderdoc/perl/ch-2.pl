#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

    A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 4

Strong Pairs: (2, 3), (2, 4), (3, 4), (3, 5)

Example 2

Input: @ints = (5, 7, 1, 7)
Ouput: 1

Strong Pairs: (5, 7)
=cut

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(min);
use Test2::V0;

is(strong_pairs(1, 2, 3, 4, 5), 4, 'Example 1');
is(strong_pairs(5, 7, 1, 7), 1, 'Example 2');
done_testing();

sub strong_pairs
{
     my @arr = @_;
     @arr = sort { $a <=> $b } @arr;
     my %output;
     my $iter = combinations(\@arr, 2);
     while (my $p = $iter->next) 
     {
          my ($x, $y) = @$p;
          if ( abs($x - $y) > 0 and abs($x - $y) < min($x, $y) )
          {
               # print join(" ", $x, $y), $/;
               $output{ join(" ", $x, $y) }++;
          }
     }
     return scalar keys %output;
}