#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of real numbers greater than zero. Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
Example 1: Input: @R = (1.2, 0.4, 0.1, 2.5) Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
Example 2: Input: @R = (0.2, 1.5, 0.9, 1.1) Output: 0
Example 3: Input: @R = (0.5, 1.1, 0.3, 0.7) Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2
=cut








use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use Test::More;





sub comb_sum
{
     my ($aref, $num, $low, $high) = @_;
     $_ *= 10 for (@$aref, $low, $high);
     my $iter = combinations($aref, $num);
     while (my $p = $iter->next)
     {
          my $sum = sum(@$p);
          return 1 if ($low < $sum and $sum < $high);
     }
     return 0;
}


is(comb_sum([1.2, 0.4, 0.1, 2.5], 3, 1, 2), 1, 'Example 1');
is(comb_sum([0.2, 1.5, 0.9, 1.1], 3, 1, 2), 0, 'Example 2');
is(comb_sum([0.5, 1.1, 0.3, 0.7], 3, 1, 2), 1, 'Example 3');

done_testing();