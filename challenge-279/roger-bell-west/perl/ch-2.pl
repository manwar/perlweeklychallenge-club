#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(splitstring('perl'), 0, 'example 1');
is(splitstring('book'), 1, 'example 2');
is(splitstring('goodmorning'), 1, 'example 3');

sub splitstring($a) {
  my $n = 0;
  foreach my $cc (split '', lc($a)) {
    if ($cc =~ /[aeiou]/) {
      $n++;
    }
  }
  return ($n % 2 == 0)?1:0;
}
