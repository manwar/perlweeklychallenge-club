#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(stringalike('textbook'), 0, 'example 1');
is(stringalike('book'), 1, 'example 2');
is(stringalike('AbCdEfGh'), 1, 'example 3');
is(stringalike('rhythmmyth'), 0, 'example 4');
is(stringalike('UmpireeAudio'), 0, 'example 5');

sub stringalike($a) {
  if (length($a) % 2 == 1) {
    return 0;
  }
  my $vt = 0;
  my $mode = 1;
  my $av = 0;
  my @sa = split('', lc($a));
  while (my ($i, $c) = each @sa) {
    if ($i * 2 == length($a)) {
      $mode = -1;
    }
    if ($c =~ /[aeiou]/) {
      $av = 1;
      $vt += $mode;
    }
  }
  ($av && ($vt == 0))?1:0;
}
