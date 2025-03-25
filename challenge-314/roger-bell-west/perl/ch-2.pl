#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(sortcolumn(['swpc', 'tyad', 'azbe']), 2, 'example 1');
is(sortcolumn(['cba', 'daf', 'ghi']), 1, 'example 2');
is(sortcolumn(['a', 'b', 'c']), 0, 'example 3');

sub arraycomp($a, $b) {
  if (scalar @{$a} != scalar @{$b}) {
    return 0;
  }
  while (my ($i, $c) = each @{$a}) {
    if ($b->[$i] ne $c) {
      return 0;
    }
  }
  1;
}

sub sortcolumn($a) {
  my @vv;
  while (my ($i, $s) = each @{$a}) {
    my @ss = split '', $s;
    while (my ($j, $c) = each @ss) {
      if ($i == 0) {
        push @vv, [];
      }
      push @{$vv[$j]}, $c;
    }
  }
  my $tot = 0;
  foreach my $x (@vv) {
    my @y = sort @{$x};
    unless (arraycomp($x, \@y)) {
      $tot++;
    }
  }
  $tot;
}
