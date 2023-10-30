#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(acronym(['Perl', 'Python', 'Pascal'], 'ppp'), 1, 'example 1');
is(acronym(['Perl', 'Raku'], 'rp'), 0, 'example 2');
is(acronym(['Oracle', 'Awk', 'C'], 'oac'), 1, 'example 3');

sub acronym($strs, $chk) {
  return (lc(join("", map {substr($_, 0, 1)} @{$strs})) eq lc($chk))?1:0;
}
