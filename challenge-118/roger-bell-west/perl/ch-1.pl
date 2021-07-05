#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(bp(5),1,'example 1');
is(bp(4),0,'example 2');

sub bp {
  my $n=shift;
  my @s=split '',sprintf('%b',$n);
  my $l=$#s;
  foreach my $i (0..int($l/2)) {
    if ($s[$i] ne $s[$l-$i]) {
      return 0;
    }
  }
  return 1;
}
