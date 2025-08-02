#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]), 1, 'example 1');
is(specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]), 3, 'example 2');

sub validator($a0) {
  my @a = sort @{$a0};
  my $l = scalar @a;
  if ($a[0] == 0 && $a[$l - 2] == 0 && $a[$l - 1] == 1) {
    foreach my $i (0 .. $l - 1) {
      if ($a0->[$i]== 1) {
        return $i;
      }
    }
  }
  return -1;
}

sub specialpositions($a) {
  my @vr = ();
  my %xs = ();
  while (my ($y, $row) = each @{$a}) {
    my $x = validator($row);
    if ($x > -1) {
      push @vr, [$y, $x];
      $xs{$x} = 1;
    }
  }
  foreach my $x (keys %xs) {
    keys @{$a};
    my @c = (map {$_->[$x]} @{$a});
    if (validator(\@c) == -1) {
      delete $xs{$x};
    }
  }
  return scalar grep {exists $xs{$_->[1]}} @vr;
}
