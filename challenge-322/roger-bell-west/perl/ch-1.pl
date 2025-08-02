#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(formatstring('ABC-D-E-F', 3), 'ABC-DEF', 'example 1');
is(formatstring('A-BC-D-E', 2), 'A-BC-DE', 'example 2');
is(formatstring('-A-B-CD-E', 4), 'A-BCDE', 'example 3');

sub formatstring($a, $n) {
  my @p = grep {$_ ne '-'} split '',$a;
  my $r = scalar @p % $n;
  if ($r == 0) {
    $r += $n;
  }
  my $o;
  while (my ($i, $c) = each @p) {
    if ($r == $i) {
      $o .= '-';
      $r += $n;
    }
    $o .= $c;
  }
  $o;
}
