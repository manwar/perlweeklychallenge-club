#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(prefixwords(['pay', 'attention', 'practice', 'attend'], 'at'), 2, 'example 1');
is(prefixwords(['janet', 'julia', 'java', 'javascript'], 'ja'), 3, 'example 2');

sub prefixwords($s, $p) {
  my $r = 0;
  foreach my $w (@{$s}) {
    if (index($w, $p) == 0) {
      $r++;
    }
  }
  return $r;
}
