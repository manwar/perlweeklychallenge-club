#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(linearrecurrencesecondorder([1, 1, 2, 3, 5]), 1, 'example 1');
is(linearrecurrencesecondorder([4, 2, 4, 5, 7]), 0, 'example 2');
is(linearrecurrencesecondorder([4, 1, 2, -3, 8]), 1, 'example 3');

use integer;

sub linearrecurrencesecondorder($seq) {
  my $a = [@{$seq}[0..2]];
  my $b = [@{$seq}[1..3]];
  my $c = [@{$seq}[2..4]];
  my $q = ($b->[2] * $a->[0] - $b->[0] * $a->[2]) / ($b->[1] * $a->[0] - $b->[0] * $a->[1]);
  my $p = ($a->[2] - $a->[1] * $q) / $a->[0];
  return ($p * $a->[0] + $q * $a->[1] == $a->[2] && $p * $b->[0] + $q * $b->[1] == $b->[2] && $p * $c->[0] + $q * $c->[1] == $c->[2])?1:0;
}
