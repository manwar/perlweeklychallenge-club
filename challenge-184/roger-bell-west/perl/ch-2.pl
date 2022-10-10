#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(splitarray(["a 1 2 b 0", "3 c 4 d"]),
          [ [[1, 2, 0], [3, 4]],
            [['a', 'b'], ['c', 'd']] ],
          'example 1');

is_deeply(splitarray(["1 2", "p q r", "s 3", "4 5 t"]),
          [ [[1, 2], [3], [4, 5]],
            [['p', 'q', 'r'], ['s'], ['t']] ],
          'example 2');

sub splitarray($list) {
  my @out = ( [], [] );
  foreach my $ins (@{$list}) {
    my @av;
    my @bv;
    foreach my $c (split '',$ins) {
      if ($c ge '0' && $c le '9') {
        push @av, 0 + $c;
      } elsif ($c ge 'a' && $c le 'z') {
        push @bv, $c;
      }
    }
    if (scalar @av > 0) {
      push @{$out[0]},\@av;
    }
    if (scalar @bv > 0) {
      push @{$out[1]},\@bv;
    }
  }
  return \@out;
}
