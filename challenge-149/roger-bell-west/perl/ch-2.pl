#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(ls(2),'1','example 1');
is(ls(4),'3201','example 2');
is(ls(10),'9814072356','example 3');
is(ls(12),'B8750A649321','example 4');

sub ls {
  my $base=shift;
  my $max=0;
  for (my $i=$base-1;$i >= 0; $i--) {
    $max *= $base;
    $max += $i;
  }
  my $t=int(sqrt($max));
  my @digits=('0'..'9','A'..'Z');
  while (1) {
    my $s=$t*$t;
    my $v=1;
    my @c=(0) x $base;
    my @dg;
    while ($s > 0) {
      my $d=$s % $base;
      $c[$d]++;
      if ($c[$d] > 1) {
        $v=0;
        last;
      }
      $s = int($s/$base);
      unshift @dg,$digits[$d];
    }
    if ($v) {
      return join('',@dg);
    }
    $t--;
  }
}
