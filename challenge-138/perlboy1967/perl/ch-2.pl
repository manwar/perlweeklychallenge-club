#!/bin/perl

=pod

The Weekly Challenge - 138
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-138/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Split Number
Submitted by: Mohammad S Anwar

You are given a perfect square.

Write a script to figure out if the square root the given number is same as sum of 2 or more splits of the given number.

=cut

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);

use Test::More;
use Test::Deep qw(cmp_deeply);

# Protoptype(s)
sub isSplitNumber($);
sub _isSN($$\@);

my %tests = (
  25   => [0,[]],
  36   => [0,[]],
  81   => [1,[8,1]],
  1296 => [1,[1,29,6]],
  2025 => [1,[20,25]],
  3025 => [1,[30,25]],
  6724 => [1,[6,72,4]],
  8281 => [1,[8,2,81]],
  9801 => [1,[98,0,1]],
 55225 => [1,[5,5,225]],
 88209 => [1,[88,209]],
);

foreach my $n (sort { $a <=> $b } keys %tests) {
  cmp_deeply(isSplitNumber($n),$tests{$n},"n=$n");
}

done_testing;

sub isSplitNumber($) {
  my ($n) = @_;

  my $iSqrt = int(sqrt($n));
  return [0,[]] if ($iSqrt != sqrt($n));

  for my $i (1 .. length($n) - 1) {
    my $j = $n;
    my $r = substr($j,0,$i,'');
    my @return = ($r);
    if (_isSN($iSqrt,$j,@return)) {
      return [1, [@return]]; 
    }
  }

  return [0,[]];
}

sub _isSN ($$\@) {
  my ($s,$n,$ar) = @_;

  if ($n !~ m#^0# && sum(@$ar,$n) == $s) {
    push(@$ar,$n);
    return 1;
  } else {
    for my $i (1 .. length($n) - 1) {
      my $j = $n;
      my $r = substr($j,0,$i,'');
      push(@$ar,$r);
      return 1 if _isSN($s,$j,@$ar);
      pop(@$ar);
    }
  }
}

