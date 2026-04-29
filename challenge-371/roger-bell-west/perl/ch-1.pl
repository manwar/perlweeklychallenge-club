#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(missingletter('a c ? g i'), 'e', 'example 1');
is(missingletter('a d ? j m'), 'g', 'example 2');
is(missingletter('a e ? m q'), 'i', 'example 3');
is(missingletter('a c f ? k'), 'h', 'example 4');
is(missingletter('b e g ? l'), 'j', 'example 5');

sub missingletter($a) {
  my @c = map {ord($_)} grep /./, split ' ', $a;
  my @d;
  foreach my $i (0 .. $#c - 1) {
    if ($c[$i] == 63 || $c[$i + 1] == 63) {
      push @d, 0;
    } else {
      push @d, $c[$i + 1] - $c[$i];
    }
  }
  while (my ($n, $delta) = each @d) {
    if ($delta == 0) {
      my $ch;
      if ($n < 2) {
        $ch = $c[$n + 2] - $d[$n + 2];
      } else {
        $ch = $c[$n] + $d[$n - 2];
      }
      return chr($ch);
    }
  }
  "";
}
