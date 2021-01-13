#! /usr/bin/perl

use strict;
use warnings;

if (rotate('xyxx') != 7) {
  die "wrong answer";
}

sub rotate {
  my $str=shift;
  my @s=split '',$str;
  my $k=scalar @s;
  my $n=0;
  while (1) {
    $n++;
    my @l=splice @s,0,($n % $k);
    push @s,@l;
    if (join('',@s) eq $str) {
      last;
    }
  }
  return $n;
}
