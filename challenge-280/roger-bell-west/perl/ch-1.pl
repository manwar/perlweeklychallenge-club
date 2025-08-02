#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(twiceappearance('acbddbca'), 'd', 'example 1');
is(twiceappearance('abccd'), 'c', 'example 2');
is(twiceappearance('abcdabbb'), 'a', 'example 3');

sub twiceappearance($a) {
  my %m;
  foreach my $c (split '', $a) {
    if (exists $m{$c}) {
      return $c;
    }
    $m{$c} = 1;
  }
  return 'x';
}
