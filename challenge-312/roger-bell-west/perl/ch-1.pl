#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(minimumtime('abc'), 5, 'example 1');
is(minimumtime('bza'), 7, 'example 2');
is(minimumtime('zjpc'), 34, 'example 3');

use List::Util qw(min);

sub transfer($a, $b) {
  my $ac = ord($a);
  my $bc = ord($b);
  min(($ac - $bc + 26) % 26, ($bc - $ac + 26) % 26);
}

sub minimumtime($a) {
  my $tot = length($a);
  my $prev = 'a';
  foreach my $c (split '', $a) {
    $tot += transfer($prev, $c);
    $prev = $c;
  }
  $tot;
}
