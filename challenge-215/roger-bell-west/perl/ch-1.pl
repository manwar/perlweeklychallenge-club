#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(oddoneout(['abc', 'xyz', 'tsu']), 1, 'example 1');
is(oddoneout(['rat', 'cab', 'dad']), 3, 'example 2');
is(oddoneout(['x', 'y', 'z']), 0, 'example 3');

sub oddoneout($a) {
  my $ct = 0;
  foreach my $s (@{$a}) {
    my $t = join('', sort split '',$s);
    if ($s ne $t) {
      $ct++;
    }
  }
  return $ct;
}
