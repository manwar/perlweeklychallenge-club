#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(shufflestring('lacelengh', [3, 2, 0, 5, 4, 8, 6, 7, 1]), 'challenge', 'example 1');
is(shufflestring('rulepark', [4, 7, 3, 1, 0, 5, 2, 6]), 'perlraku', 'example 2');

sub shufflestring($st, $mp) {
  my @q = split '',$st;
  my @r = ' ' x scalar @q;
  foreach my $i (0 .. $#{$mp}) {
    $r[$mp->[$i]] = $q[$i];
  }
  return join('',@r);
}
