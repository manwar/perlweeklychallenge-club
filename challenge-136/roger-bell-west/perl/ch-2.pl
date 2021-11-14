#! /usr/bin/perl

use strict;

use Test::More tests => 3;

is(fibseq(16),4,'example 1');
is(fibseq(9),2,'example 2');
is(fibseq(15),2,'example 3');

sub fibseq {
  my $m=shift;
  return f($m,1,1);
}

sub f {
  my ($x,$y,$z)=@_;
  if ($x < $y) {
    return ($x==0)?1:0;
  } else {
    return f($x-$y,$y+$z,$y)+f($x,$y+$z,$y);
  }
}
