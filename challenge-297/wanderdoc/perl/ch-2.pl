#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a semi-ordered permutation.

A permutation is a sequence of integers from 1 to n of length n containing  each number exactly once.
A permutation is called semi-ordered if the first number is 1 and the last number equals n.

You are ONLY allowed to pick adjacent elements and swap them.
Example 1

Input: @ints = (2, 1, 4, 3)
Output: 2

Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example 2

Input: @ints = (2, 4, 1, 3)
Output: 3

Swap 4 <=> 1 => (2, 1, 4, 3)
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example 3

Input: @ints = (1, 3, 2, 4, 5)
Output: 0

Already a semi-ordered permutation.

=cut


# use List::Util qw(first);
use List::MoreUtils qw(first_index);
use Test2::V0 -no_srand => 1;

is(min_swaps(2, 1, 4, 3), 2, 'Example 1');
is(min_swaps(2, 4, 1, 3), 3, 'Example 2');
is(min_swaps(1, 3, 2, 4, 5), 0, 'Example 3');
is(min_swaps(1), 0, 'Example 4');
is(min_swaps(5, 4, 3, 2, 1), 7, 'Example 5');

done_testing();

sub min_swaps 
{
     my @arr = @_;
     my $idx_1 = first_index { $_ == 1 } @arr;
     my $idx_n = first_index { $_ == scalar @arr } @arr;
     my $steps = $idx_1; # $idx_1 - 0.
     $steps += ($#arr - $idx_n);
     $steps-- if ($idx_n < $idx_1);
     return $steps;
}
