#!/bin/perl

=pod

The Weekly Challenge - 247
- https://theweeklychallenge.org/blog/perl-weekly-challenge-247

Author: Niels 'PerlBoy' van Dijke

Task 2: Most Frequent Letter Pair
Submitted by: Jorg Sommrey

You are given a string S of lower case letters 'a'..'z'.

Write a script that finds the pair of consecutive letters in S that appears most frequently.
If there is more than one such pair, chose the one that is the lexicographically first.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0;

use List::Util qw(uniq max);
use Algorithm::Combinatorics qw(variations);

sub mostFrequentLetterPair($string) {
  my @chars = uniq sort split //, $string;
  my $l = length $string;

  my %count;

  for my $p (variations(\@chars,2)) {
    next if $$p[0] eq $$p[1];
    my $c2 = $$p[0].$$p[1];
    $count{$c2} = ($l - length ($string =~ s/$c2//gr))/2;
  }

  my $m = max(values %count);

  return (sort grep { $count{$_} == $m } keys %count)[0];
}

is(mostFrequentLetterPair('abcdbca'),'bc');
is(mostFrequentLetterPair('cdeabeabfcdfabgcd'),'ab');

done_testing;
