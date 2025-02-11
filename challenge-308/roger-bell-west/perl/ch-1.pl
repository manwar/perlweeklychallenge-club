#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(countcommon(['perl', 'weekly', 'challenge'], ['raku', 'weekly', 'challenge']), 2, 'example 1');
is(countcommon(['perl', 'raku', 'python'], ['python', 'java']), 1, 'example 2');
is(countcommon(['guest', 'contribution'], ['fun', 'weekly', 'challenge']), 0, 'example 3');

sub countcommon($a, $b) {
  my %aa = map {$_ => 1} @{$a};
  my %bb = map {$_ => 1} @{$b};
  scalar grep {exists $bb{$_}} keys %aa;
}
