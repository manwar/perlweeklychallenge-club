#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-361#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Zeckendorf Representation
Submitted by: Mohammad Sajid Anwar

You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

||  Every positive integer can be uniquely represented as sum of non-consecutive Fibonacci numbers.


=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

# Standard Fibonacci function with caching through 'state'
sub fib {
  state %c = (0 => 0, 1 => 1);
  $c{$_[0]} //= fib($_[0] - 1) + fib($_[0] - 2);
}

sub zeckendorfRepresentation ($n) {
  my ($i,@fib) = (2,fib(1),fib(2));

  push(@fib, fib($i++)) while (fib($i) <= $n);

  my @result;

  for my $f (reverse @fib) {
    next if $f > $n;
    push @result, $f;
    $n -= $f;
    last if $n == 0;
  }

  return @result;
}

is([zeckendorfRepresentation(4)],[3,1],'Example 1');
is([zeckendorfRepresentation(12)],[8,3,1],'Example 2');
is([zeckendorfRepresentation(20)],[13,5,2],'Example 3');
is([zeckendorfRepresentation(96)],[89,5,2],'Example 4');
is([zeckendorfRepresentation(100)],[89,8,3],'Example 5');

done_testing;
