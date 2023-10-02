#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

use List::Util qw(max);

is(maximumproduct([3, 1, 2]), 6, 'example 1');
is(maximumproduct([4, 1, 3, 2]), 24, 'example 2');
is(maximumproduct([-1, 0, 1, 3, 1]), 3, 'example 3');
is(maximumproduct([-8, 2, -9, 0, -4, 3]), 216, 'example 4');

sub maximumproduct($lst) {
  my @l = sort {$a <=> $b} @{$lst};
  my $b = scalar @l;
  my @t;
  foreach my $i (0..3) {
    my $p = 1;
    if ($i > 0) {
      foreach my $j (0..$i-1) {
        $p *= $l[$j];
      }
    }
    if ($i < 3) {
      foreach my $j ($b-3+$i..$b-1) {
        $p *= $l[$j];
      }
    }
    push @t, $p;
  }
  return max(@t);
}
