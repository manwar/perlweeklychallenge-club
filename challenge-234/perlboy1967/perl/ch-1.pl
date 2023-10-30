#!/bin/perl

=pod

The Weekly Challenge - 234
- https://theweeklychallenge.org/blog/perl-weekly-challenge-234

Author: Niels 'PerlBoy' van Dijke

Task 1: Common Characters
Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabetic characters only.

Write a script to return all alphabetic characters that show up in all
words including duplicates.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::Util qw(min);

sub commonCharacters (@) {
  my (%c,%wc,@r);

  # Find (total and word) character frequencies
  for (@_) {
    for my $c (split //) {
      $c{$c}++; 
      $wc{$c}{$_}++;
    }
  }

  # Find same frequency of characters across all words
  for my $c (grep { $c{$_} >= scalar @_ } sort keys %c) {
    push(@r,($c) x min map { $wc{$c}{$_} // 0 } @_);
  }

  return @r;
}

cmp_deeply([commonCharacters(qw{java javascript julia})],[qw{a j}]);
cmp_deeply([commonCharacters(qw{bella label roller})],[qw{e l l}]);
cmp_deeply([commonCharacters(qw{cool lock cook})],[qw{c o}]);

done_testing;
