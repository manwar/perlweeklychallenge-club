#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxoddbinary('1011'), '1101', 'example 1');
is(maxoddbinary('100'), '001', 'example 2');
is(maxoddbinary('111000'), '110001', 'example 3');
is(maxoddbinary('0101'), '1001', 'example 4');
is(maxoddbinary('1111'), '1111', 'example 5');

sub maxoddbinary($a) {
  my $ones = 0;
  my $zeroes = 0;
  foreach my $c (split '', $a) {
    if ($c eq '0') {
      $zeroes++;
    } elsif ($c eq '1') {
      $ones++;
    }
  }
  if ($ones < 1) {
    return '';
  }
  my $out = '';
  $out .= '1' x ($ones - 1);
  $out .= '0' x $zeroes;
  $out .= '1';
  $out;
}
