#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(changingkeys('pPeERrLl'), 3, 'example 1');
is(changingkeys('rRr'), 0, 'example 2');
is(changingkeys('GoO'), 1, 'example 3');

sub changingkeys($a) {
  my $oc = 'x';
  my $out = 0;
  my @s = split('', lc($a));
  while (my ($i, $c) = each @s) {
    if ($i == 0) {
      $oc = $c;
    } elsif ($c ne $oc) {
      $oc = $c;
      $out++;
    }
  }
  return $out;
}
