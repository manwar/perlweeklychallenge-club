#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(maximumaverage([1, 12, -5, -6, 50, 3], 4), 12.75, 'example 1');
is(maximumaverage([5], 1), 5, 'example 2');

use List::Util qw(sum max);
use List::MoreUtils qw(slideatatime);

sub maximumaverage($a, $n) {
  my $mx = 0;
  my $dd = slideatatime 1, $n, @{$a};
  while (my @s = $dd->()) {
    if (scalar @s == $n) {
      $mx = max($mx, sum(@s));
    }
  }
  $mx / $n;
}
