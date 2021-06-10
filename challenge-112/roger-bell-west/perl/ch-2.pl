#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(cs(3),3,'example 1');
is(cs(4),5,'example 2');
is(cs(20),10946,'example 3');

sub cs {
  my $i=shift;
  my ($a,$b,$c)=(0,1,0);
  foreach (1..$i) {
    $c=$a+$b;
    ($a,$b)=($b,$c);
  }
  return $c;
}
