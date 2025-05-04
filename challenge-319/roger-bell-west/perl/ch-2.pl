#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]), 3, 'example 1');
is(minimumcommon([1, 2, 3], [2, 4]), 2, 'example 2');
is(minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]), -1, 'example 3');

use List::Util qw(min);

sub minimumcommon($a, $b) {
  my %aa = map {$_ => 1} @{$a};
  my %bb = map {$_ => 1} @{$b};
  my %cc = map {$_ => 1} grep {exists $bb{$_}} keys %aa;
  if (scalar keys %cc > 0) {
    min(keys %cc);
  } else {
    -1;
  }
}
