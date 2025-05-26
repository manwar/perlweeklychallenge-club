#!/bin/perl

=pod

The Weekly Challenge - 323
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-323#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Increment Decrement
Submitted by: Mohammad Sajid Anwar

You are given a list of operations.

Write a script to return the final value after performing the given
operations in order. The initial value is always 0.

|| Possible Operations:
|| ++x or x++: increment by 1
|| --x or x--: decrement by 1

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::Util qw(sum);

sub incDec (@str) {
  state $op = {
    'x++' => 1, 'x--' => -1,
    '++x' => 1, '--x' => -1,
  };
  sum( map { $op->{$_} // 0 } @str);
}

is(incDec(qw{--x x++ x++}),1,'Example 1');
is(incDec(qw{x++ ++x x++}),3,'Example 2');
is(incDec(qw{x++ ++x --x x--}),0,'Example 2');
is(incDec(qw{x++ bogus op}),1,'Own example');

done_testing;
