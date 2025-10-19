#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxscore('0011'), 4, 'example 1');
is(maxscore('0000'), 3, 'example 2');
is(maxscore('1111'), 3, 'example 3');
is(maxscore('0101'), 3, 'example 4');
is(maxscore('011101'), 5, 'example 5');

use List::Util qw(max);
sub maxscore($a) {
  my $zeroestoleft = 0;
  my $onestoright = length($a);
  my $maxscore = 0;
  my @sa = split('', $a);
  while (my ($i, $c) = each @sa) {
    if ($c eq '0') {
      $zeroestoleft++;
    } elsif ($c eq '1') {
      $onestoright--;
    }
    if ($i + 1 < length($a)) {
      $maxscore = max($maxscore, $zeroestoleft + $onestoright);
    }
  }
  $maxscore - $onestoright;
}
