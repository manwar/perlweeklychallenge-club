#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(swap('perlandraku',3,4),
   'pndraerlaku',
   'example 1',
     );

sub swap {
  my $s=shift;
  my $c=shift;
  my $o=shift;
  my $n=length($s);
  my @s=split '',$s;
  foreach my $ci (1..$c) {
    ($s[$ci % $n],$s[($ci+$o) % $n]) = ($s[($ci+$o) % $n],$s[$ci % $n]);
  }
  return join('',@s);
}
