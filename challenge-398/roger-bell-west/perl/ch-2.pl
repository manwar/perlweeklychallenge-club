#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(stringdifference(['ab', 'bc', 'cd', 'zy']), 'zy', 'example 1');
is(stringdifference(['cba', 'fed', 'azy']), 'azy', 'example 2');
is(stringdifference(['pop', 'ada', 'beb', 'cfc']), 'pop', 'example 3');
is(stringdifference(['aaaa', 'zzzz', 'mmmm', 'aaba']), 'aaba', 'example 4');
is(stringdifference(['aceg', 'bdfh', 'cegi', 'azbz']), 'azbz', 'example 5');

use List::MoreUtils qw(slideatatime);

sub stringdifference($a) {
  my @da;
  foreach my $s (@{$a}) {
    my @p;
    my $it = slideatatime(1, 2, split '', $s);
    while (my @d = $it->()) {
      if (scalar @d == 2) {
        push @p, ord($d[1]) - ord($d[0]);
      }
    }
    push @da, join('/', @p);
  }
  my $dx = 0;
  foreach my $b (1..$#{$a}) {
    if ($da[0] ne $da[$b]) {
      if ($dx > 0) {
        $dx = 0;
        last;
      } else {
        $dx = $b;
      }
    }
  }
  $a->[$dx];
}
