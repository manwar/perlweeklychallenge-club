#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(echochamber('abca'), 'abbcccaaaa', 'example 1');
is(echochamber('xyz'), 'xyyzzz', 'example 2');
is(echochamber('code'), 'coodddeeee', 'example 3');
is(echochamber('hello'), 'heelllllllooooo', 'example 4');
is(echochamber('a'), 'a', 'example 5');

sub echochamber($a) {
  my $out = '';
  my @s = split '', $a;
  while (my ($i, $c) = each @s) {
    $out .= $c x ($i + 1);
  }
  $out;
}
