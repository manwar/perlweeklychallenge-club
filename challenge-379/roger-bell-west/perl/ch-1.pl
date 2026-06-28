#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(reversestring(''), '', 'example 1');
is(reversestring('reverse the given string'), 'gnirts nevig eht esrever', 'example 2');

sub reversestring($a) {
  if ($a eq '') {
    return $a;
  }
  my $b = '';
  my $l = length($a) - 1;
  my @aa = split '', $a;
  foreach my $i (0 .. $l) {
    $b .= $aa[$l - $i];
  }
  $b;
}
