#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(specialbitcharacters([1, 0, 0]), 1, 'example 1');
is(specialbitcharacters([1, 1, 1, 0]), 0, 'example 2');

sub specialbitcharacters($a) {
  my $s = 0;
  foreach my $v (@{$a}) {
    if ($s == 1) {
      $s = 2;
    } else {
      $s = $v;
    }
  }
  return ($s == 0)?1:0;
}
