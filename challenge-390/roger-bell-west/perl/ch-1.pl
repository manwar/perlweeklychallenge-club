#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(decodestring('2[3[a]]'), 'aaaaaa', 'example 1');
is(decodestring('10[a]'), 'aaaaaaaaaa', 'example 2');
is(decodestring('a2[b]c3[d]e'), 'abbcddde', 'example 3');
is(decodestring('2[a2[b]c]'), 'abbcabbc', 'example 4');
is(decodestring('1[a]2[b3[c]]'), 'abcccbccc', 'example 5');

sub decodestring($a) {
  while ($a =~ /(([0-9]+)\[([^\[\]]*)\])/) {
    my $orig = $1;
    my $ct = $2;
    my $rep = $3;
    my $dest = $rep x $ct;
    my $l = length($orig);
    while (1) {
      my $ix = index($a, $orig);
      if ($ix == -1) {
        last;
      } else {
        substr($a, $ix, $l) = $dest;
      }
    }
  }
  $a;
}
