#! /usr/bin/perl

use strict;

use Test::More tests => 4;

is(lychrel(56),0,'example 1');
is(lychrel(57),0,'example 2');
is(lychrel(59),0,'example 3');
is(lychrel(196),-1,'example 4');

sub lychrel {
  my $n=shift;
  foreach (1..100) {
    my $m=join('',reverse split '',$n);
    if ($m==$n) {
      return 0;
    }
    $n+=$m;
    if ($n>=10000000) {
      last;
    }
  }
  return -1;
}
