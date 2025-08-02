#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(sum);

sub matchsticksquare($a) {
  my $perimeter = sum(@{$a});
  if ($perimeter % 4 != 0) {
    return 0;
  }
  my $side = $perimeter / 4;
  my @ss = sort {$b <=> $b} @{$a};
  my $sidesleft = 4;
  my $lengthleft = $side;
  while (1) {
    my @leftover;
    foreach my $m (@ss) {
      if ($m > $side) {
        return 0;
      }
      if ($m <= $lengthleft) {
        $lengthleft -= $m;
        if ($lengthleft == 0) {
          $sidesleft--;
          $lengthleft = $side;
        }
      } else {
        push @leftover, $m;
      }
    }
      if (scalar @leftover == 0) {
        last;
      }
    @ss = @leftover;
  }
  ($sidesleft == 0 && $lengthleft == $side)?1:0;
}

use Test::More tests => 4;

is(matchsticksquare([1, 2, 2, 2, 1]), 1, 'example 1');
is(matchsticksquare([2, 2, 2, 4]), 0, 'example 2');
is(matchsticksquare([2, 2, 2, 2, 4]), 0, 'example 3');
is(matchsticksquare([3, 4, 1, 4, 3, 1]), 1, 'example 4');
