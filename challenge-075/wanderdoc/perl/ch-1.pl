#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a set of coins @C, assuming you have infinite amount of each coin in the set.
Write a script to find how many ways you make sum $S using the coins from the set @C.
Example: Input: @C = (1, 2, 4) $S = 6
Output: 6
There are 6 possible ways to make sum 6.
a) (1, 1, 1, 1, 1, 1) b) (1, 1, 1, 1, 2) c) (1, 1, 2, 2) d) (1, 1, 4) e) (2, 2, 2) f) (2, 4)
=cut




use Algorithm::Combinatorics qw(combinations_with_repetition);
use List::Util qw(sum);

sub coin_change
{
     my($coins, $sum) = @_;
     my @arr = sort {$a<=>$b} @$coins;

     my $counter = 0;

     for my $k ( 1 ..  $sum/$arr[0])
     {
          my $iter = combinations_with_repetition(\@arr, $k);
          while (my $p = $iter->next)
          {
               print join(': ', ++$counter, join('+', @$p)), $/ if sum(@$p) == $sum;
          }
     }
     print "No solution for [@arr] and ${sum}.$/" and return unless $counter;
     print "There are ${counter} possible ways to make sum ${sum}.$/";
}



coin_change([100, 50, 20, 10, 5], 100);
coin_change([1, 2, 4], 6);
coin_change([2, 10, 20], 15);