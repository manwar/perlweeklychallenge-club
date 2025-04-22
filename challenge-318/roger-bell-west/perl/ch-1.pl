#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(groupposition('abccccd'), ['cccc'], 'example 1');
is_deeply(groupposition('aaabcddddeefff'), ['aaa', 'dddd', 'fff'], 'example 2');
is_deeply(groupposition('abcdd'), [], 'example 3');

sub groupposition($a) {
  my @mx;
  my $lc = 'z';
  my @a = split '', $a;
  while (my ($i, $c) = each @a) {
    if ($i == 0) {
      $lc = chr(ord($c) + 1);
    }
    if ($lc eq $c) {
      my $mc = scalar @mx;
      $mx[$mc - 1][1] += 1;
    } else {
      push @mx, [$c, 1];
      $lc = $c;
    }
  }
  my @out;
  foreach my $ms (@mx) {
    if ($ms->[1] >= 3) {
      push @out, $ms->[0] x $ms->[1];
    }
  }
  \@out;
}
