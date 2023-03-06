#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(arraypairing([1, 2, 3, 4]), 4, 'example 1');
is(arraypairing([0, 2, 1, 3]), 2, 'example 2');

use Algorithm::Combinatorics qw(combinations permutations);
use List::Util qw(min max);

sub arraypairing($n) {
  my $nl = scalar @{$n};
  if ($nl % 2 == 1) {
    return 0;
  }
  my $hl = $nl / 2;
  my @out;
  my $ic = combinations([0 .. $nl-1], $hl);
  while (my $px = $ic->next) {
    my @pa = map {$n->[$_]} @{$px};
    my %ps = map {$_ => 1} @{$px};
    my @pb = map {$n->[$_]} grep {!exists $ps{$_}} (0 .. $nl-1);
    my $ip = permutations(\@pa);
    while (my $pp = $ip->next) {
      my $s = 0;
      foreach my $i (0 .. $hl-1) {
        $s += min($pp->[$i], $pb[$i]);
      }
      push @out,$s;
    }
  }
  return max(@out);
}
