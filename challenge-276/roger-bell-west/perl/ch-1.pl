#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(completeday([12, 12, 30, 24, 24]), 2, 'example 1');
is(completeday([72, 48, 24, 5]), 3, 'example 2');
is(completeday([12, 18, 24]), 0, 'example 3');

use Algorithm::Combinatorics qw(combinations);

sub completeday($a) {
  my $out = 0;
  my $ip = combinations($a, 2);
  while (my $c = $ip->next) {
    if (($c->[0] + $c->[1]) % 24 == 0) {
      $out++;
    }
  }
  return $out;
}
