#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(twoofthree([[1, 1, 2, 4], [2, 4], [4]]), [2, 4], 'example 1');
is_deeply(twoofthree([[4, 1], [2, 4], [1, 2]]), [1, 2, 4], 'example 2');

sub twoofthree($a) {
  my %ct;
  foreach my $iv (@{$a}) {
    my %i;
    map {$i{$_} = 1} @{$iv};
    map {$ct{$_}++} keys %i;
  }
  my @out;
  while (my ($k, $v) = each %ct) {
    if ($v >= 2) {
      push @out, $k;
    }
  }
  return [sort @out];
}
