#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(leftrot([10, 20, 30, 40, 50],[3, 4]),
          [[40, 50, 10, 20, 30],
           [50, 10, 20, 30, 40]],
          'example 1');
is_deeply(leftrot([7, 4, 2, 6, 3],[1, 3, 4]),
          [[4, 2, 6, 3, 7],
           [6, 3, 7, 4, 2],
           [3, 7, 4, 2, 6]],
          'example 2');

sub leftrot {
  my $a=shift;
  my $b=shift;
  my $l=scalar(@{$a})-1;
  my @t=(@{$a},@{$a});
  my @o;
  foreach my $c (@{$b}) {
    push @o,[@t[$c..$c+$l]];
  }
  return \@o;
}
