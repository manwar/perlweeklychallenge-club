#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(groupdigitsum('111122333', 3), '359', 'example 1');
is(groupdigitsum('1222312', 2), '76', 'example 2');
is(groupdigitsum('100012121001', 4), '162', 'example 3');

sub groupdigitsum($a, $sz) {
  my $s = $a;
  my $n = 0;
  while (1) {
    my $t = '';
    my @cc = split '',$s;
    while (my ($i, $c) = each @cc) {
      $n += $c;
      if ($i == length($s) - 1 || ($i + 1) % $sz == 0) {
        $t .= $n;
        $n = 0;
      }
    }
    $s = $t;
    if (length($s) <= $sz) {
      last;
    }
  }
  $s;
}
