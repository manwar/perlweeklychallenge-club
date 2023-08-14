#!/bin/perl

=pod

The Weekly Challenge - 229
- https://theweeklychallenge.org/blog/perl-weekly-challenge-229

Author: Niels 'PerlBoy' van Dijke

Task 2: Two out of Three
Submitted by: Mohammad S Anwar

You are given three array of integers.

Write a script to return all the elements that are present in at least 
2 out of 3 given arrays.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep;

use List::Util qw(uniq);

sub twoOutOfThree (\@\@\@) {
  my (@n,%n);

  push(@n,{map { $n{$_}++; ($_,1) } @$_}) for @_;

  return grep {
    my $n = $_; 
    scalar(grep{exists $_->{$n} } @n) >= 2;
  } sort { $a <=> $b } uniq(keys %n);
}

cmp_deeply([twoOutOfThree(@{[1,1,2,4]},@{[2,4]},@{[4]})],[2,4]);
cmp_deeply([twoOutOfThree(@{[4,1]},@{[2,4]},@{[1,2]})],[1,2,4]);

done_testing;
