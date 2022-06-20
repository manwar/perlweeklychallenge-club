#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(kronecker([[1,2],[3,4]],
                    [[5,6],[7,8]]),
          [
            [ 5,  6, 10, 12],
            [ 7,  8, 14, 16],
            [15, 18, 20, 24],
            [21, 24, 28, 32]
              ],
          'example 1');

sub kronecker($a,$b) {
  my @o;
  my $ax = scalar @{$a->[0]};
  my $ay = scalar @{$a};
  my $bx = scalar @{$b->[0]};
  my $by = scalar @{$b};
  foreach my $y (0..$ay*$by-1) {
    my $byi = $y % $by;
    my $ayi = int($y / $by);
    my @row;
    foreach my $x (0..$ax*$bx-1) {
      my $bxi = $x % $bx;
      my $axi = int($x / $bx);
      push @row,$a->[$ayi][$axi] * $b->[$byi][$bxi];
  }
  push @o,\@row;
  }
  return \@o;
}
