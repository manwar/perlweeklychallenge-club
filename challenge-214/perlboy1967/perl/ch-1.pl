#!/bin/perl

=pod

The Weekly Challenge - 214
- https://theweeklychallenge.org/blog/perl-weekly-challenge-214

Author: Niels 'PerlBoy' van Dijke

Task 1: Rank Score
Submitted by: Mohammad S Anwar

You are given a list of scores (>=1).

Write a script to rank each score in descending order. First three will get medals
i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking number.

|| Using the standard model of giving equal scores equal rank, then advancing that 
|| number of ranks.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep;

use List::MoreUtils qw(uniq indexes);

sub rankScore {
  state $medals = {1=>'G', 2=>'S', 3=>'B'};
  my @uniqScores = sort { $b <=> $a } uniq @_;
  my ($rank,@ranks) = (1);

  for my $score (@uniqScores) {
    my @indexes = indexes { $_ == $score } @_;
    map { $ranks[$_] = $medals->{$rank} // $rank } @indexes;
    $rank += scalar(@indexes);
  }

  return @ranks;

}

cmp_deeply([rankScore(1,2,4,3,5)],[qw(5 4 S B G)]);
cmp_deeply([rankScore(8,5,6,7,4)],[qw(G 4 B S 5)]);
cmp_deeply([rankScore(3,5,4,2)],[qw(B G S 4)]);
cmp_deeply([rankScore(2,5,2,1,7,5,1)],[qw(4 S 4 6 G S 6)]);
cmp_deeply([rankScore(1,2,3,3,3,3)],[qw(6 5 G G G G)]);
cmp_deeply([rankScore(1,2,2,3,3)],[qw(5 B B G G)]);

done_testing;


