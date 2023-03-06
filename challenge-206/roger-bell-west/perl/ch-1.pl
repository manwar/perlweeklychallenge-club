#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(shortesttime(['00:00', '23:55', '20:00']), 5, 'example 1');
is(shortesttime(['01:01', '00:50', '00:57']), 4, 'example 2');
is(shortesttime(['10:10', '09:30', '09:00', '09:55']), 15, 'example 3');

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(min);

sub shortesttime($n) {
  my $dl = 1440;
  my @nl = map {/(\d+):(\d+)/; 60*$1+$2} @{$n};
  my $i = combinations(\@nl, 2);
  my @o;
  while (my $p = $i->next) {
    my $d = abs($p->[0] - $p->[1]);
    push @o, $d;
    push @o, $dl - $d;
  }
  return min(@o);
}
