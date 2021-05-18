#!/usr/bin/perl

# Perl Weekly Challenge - 113
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
#
# Task 2 - Recreate Binary Tree
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;
use Test::Deep;

my %tests = (
  'Test 1' => [
    [ 1,[ 2,[ 4,[undef, 7]]],[ 3,[ 5, 6]]],
    [27,[26,[24,[undef,21]]],[25,[23,22]]]
  ],
  'Test 2' => [
    [2,[3,[undef,2]],[undef,4]],
    [9,[8,[undef,9]],[undef,7]]
  ],
);
  
foreach my $test (keys %tests) {
  my ($t,$res) = @{$tests{$test}};
  updateTree($t,sumOfTree($t));
  cmp_deeply($t,$res);
}

done_testing;

sub sumOfTree {
  my ($arT) = @_;

  my $sum;
  foreach my $n (@$arT) {
    if (ref($n) eq 'ARRAY') {
      $sum += sumOfTree($n);
    } elsif (defined $n) {
      $sum += $n;
    }
  }

  return $sum;
}

sub updateTree {
  my ($arT, $sum) = @_;

  foreach my $n (@$arT) {
    if (ref($n) eq 'ARRAY') {
      updateTree($n,$sum);
    } elsif (defined $n) {
      $n = $sum - $n;
    }
  }
}
