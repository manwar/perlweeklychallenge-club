#!/usr/bin/perl

# Perl Weekly Challenge - 124
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-124/#TASK2
#
# Task 1 - Tug of War
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;
use POSIX qw(ceil);

use List::Util qw(min sum);
use List::MoreUtils qw(pairwise);
use Algorithm::Combinatorics qw(derangements);

use Test::More;
use Test::Deep;

# Prototype(s)
sub tugOfWar(\@);

my $tests = [ 
   [ 
     [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
     [10, 20, 50, 90, 100],
     [30, 40, 60, 70, 80],
   ],
   [ 
     [10, -15, 20, 30, -25, 0, 5, 40, -5],
     [-25, -5, 20, 40],
     [-15, 0, 5, 10, 30],
  ],
  [
    [1,2,3,4],
    [1,4],
    [2,3]
  ],
  [
    [0,0,1],
    [0],
    [0,1],
  ],
];

foreach my $t (@$tests) {
  my @in = @{shift(@$t)};
  cmp_deeply(tugOfWar(@in),$t);
}

done_testing();


sub tugOfWar(\@) {
  my ($ar) = @_;

  my @ret;
  my ($min,$sum1,$sum2);

  my $s = scalar(@$ar)>>1;

  # Find the two lists with the smallest
  # difference of the sum of their elements
  my $iter = derangements($ar);
  while (my $arP = $iter->next) {
    my @arL = splice(@$arP,0,$s);
    foreach (0 .. scalar(@$ar)-2*$s) {
      ($sum1,$sum2) = (sum(@arL),sum(@$arP));
      my $diff = abs($sum1-$sum2);
      if (!defined $min or $diff < $min) {
        $min = $diff;
        @ret = ([@arL],[@$arP]);
        last if $min == 0;
      }
      # Prepare for second pass if 
      # number of elements in @$ar is odd
      if (scalar(@$ar) > 2*$s) {
        push(@arL,shift(@$arP));
      }
    }
  }

  # Sort output lists
  @ret = (
    [sort { $a <=> $b} @{$ret[0]}],
    [sort { $a <=> $b} @{$ret[1]}]
  );

  # Order the output lists
  ($sum1,$sum2) = (sum(@{$ret[0]}),sum(@{$ret[1]}));
  if ($sum1 > $sum2) {
    @ret = reverse @ret;
  } elsif ($sum1 == $sum2) {
    my $i = 0;
    pairwise { $i = ($a <=> $b) unless $i} @{$ret[0]}, @{$ret[1]};
    @ret = reverse @ret if ($i == 1);
  }

  return [@ret];
}
