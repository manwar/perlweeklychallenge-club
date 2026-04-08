#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(makeitbigger('15456', '5'), '1546', 'example 1');
is(makeitbigger('7332', '3'), '732', 'example 2');
is(makeitbigger('2231', '2'), '231', 'example 3');
is(makeitbigger('543251', '5'), '54321', 'example 4');
is(makeitbigger('1921', '1'), '921', 'example 5');

use List::Util qw(max);

sub makeitbigger($st, $ch) {
  my @nv;
  my $i = index($st, $ch);
  while ($i > -1) {
    my $o = $st;
    substr($o, $i, 1) = "";
    push @nv, 0 + $o;
    $i = index($st, $ch, $i + 1);
  }
  max(@nv);
}
