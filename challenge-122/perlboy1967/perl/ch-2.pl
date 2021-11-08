#!/usr/bin/perl

# Perl Weekly Challenge - 122
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-122/#TASK2
#
# Task 1 - Basketball Points
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);

use Test::More;
use Test::Deep qw(cmp_deeply);

# Prototype(s)
sub basketballPoints($);
sub _bp($$$);


my $tests = [ 
   [ 3, [1,1,1],[1,2],[2,1],[3] ],
   [ 4, [1,1,1,1],[1,1,2],[1,2,1],[1,3],[2,1,1],[2,2],[3,1] ],
   [ 5, [1,1,1,1,1],[1,1,1,2],[1,1,2,1],[1,1,3],[1,2,1,1],[1,2,2],[1,3,1],[2,1,1,1],[2,1,2],[2,2,1],[2,3],[3,1,1],[3,2] ],
];

foreach my $t (@$tests) {
  my $n = shift(@$t);
  printf "failed: %d\n", $n unless cmp_deeply(basketballPoints($n),$t);
}

done_testing();


sub basketballPoints($) {
  my ($n) = @_;

  if ($n == 1) {
    return [[1]];
  } elsif ($n == 2) {
    return [[1,1],[2]];
  }

  my $res = [];
  return _bp($n,$res,[]);
}  

sub _bp ($$$) {
  my ($n,$arRes,$arTmp) = @_;

  for my $i (1 .. ($n > 3 ? 3 : $n)) {
    push(@$arTmp,$i);
    my $s = sum(@$arTmp);
    if ($s == $n) {
      push(@$arRes,[@$arTmp]);
    } elsif ($s < $n) {
      _bp($n,$arRes,$arTmp);
    }
    pop(@$arTmp);
  }

  return $arRes;
}
