#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(converttime('02:30', '02:45'), 1, 'example 1');
is(converttime('11:55', '12:15'), 2, 'example 2');
is(converttime('09:00', '13:00'), 4, 'example 3');
is(converttime('23:45', '00:30'), 3, 'example 4');
is(converttime('14:20', '15:25'), 2, 'example 5');

sub hm2m($a) {
    $a =~ /(\d+):(\d+)/;
    $1 * 60 + $2;
}

sub converttime($ssrc, $ttgt) {
  my $src = hm2m($ssrc);
  my $tgt = hm2m($ttgt);
  if ($tgt < $src) {
    $tgt += 24 * 60;
  }
  my $delta = $tgt - $src;
  my $oc = 0;
  foreach my $op (60, 15, 5, 1) {
    $oc += int($delta / $op);
    $delta %= $op;
  }
  $oc;
}
