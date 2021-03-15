#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(pn(1221),1,'example 1');
is(pn(-101),0,'example 2');
is(pn(90),0,'example 3');

sub pn {
  my $n=shift;
  return (join('',reverse split '',$n) eq $n)?1:0;
}
