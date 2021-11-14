#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(splnum(81),1,'example 1');
is(splnum(9801),1,'example 2');
is(splnum(36),0,'example 3');

sub splnum {
  my $n=shift;
  my $k=int(sqrt($n));
  if ($k*$k != $n) {
    return 0;
  }
  my @d=split('',$n);
  foreach my $s (1..(1<<($#d))-1) {
    my @s=(0);
    foreach my $i (0..$#d-1) {
      if ($s & 1<<$i) {
        push @s,$i+1;
      }
    }
    push @s,$#d+1;
    my $c=0;
    foreach my $j (0..$#s-1) {
      $c+=join('',@d[$s[$j]..$s[$j+1]-1]);
    }
    if ($c == $k) {
      return 1;
    }
  }
  return 0;
}
