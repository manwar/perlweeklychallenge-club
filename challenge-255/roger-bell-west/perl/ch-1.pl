#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(oddcharacter('Perl', 'Preel'), 'e', 'example 1');
is(oddcharacter('Weekly', 'Weeakly'), 'a', 'example 2');
is(oddcharacter('Box', 'Boxy'), 'y', 'example 3');

sub oddcharacter($s, $t) {
  my %ss;
  map {$ss{$_}++} split '',$s;
  foreach my $c (split '', $t) {
    if (exists $ss{$c} && $ss{$c} > 0) {
      $ss{$c}--;
    } else {
      return $c;
    }
  }
  return '@';
}
