#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(dotproduct([1,2,3],[4,5,6]),32,'example 1');

sub dotproduct {
  my $a=shift;
  my $b=shift;
  my $p=0;
  foreach my $i (0..$#{$a}) {
    $p += $a->[$i]*$b->[$i];
  }
  return $p;
}
