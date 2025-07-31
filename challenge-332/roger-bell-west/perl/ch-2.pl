#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(oddletters('weekly'), 0, 'example 1');
is(oddletters('perl'), 1, 'example 2');
is(oddletters('challenge'), 0, 'example 3');

sub oddletters($a) {
  my %c;
  map {$c{$_}++} split '', $a;
  foreach my $v (values %c) {
    if ($v % 2 == 0) {
      return 0;
    }
  }
  return 1;
}
