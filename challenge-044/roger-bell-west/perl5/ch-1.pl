#! /usr/bin/perl

use strict;
use warnings;

use integer;

my @base=(1..9);

my @sv=('','-','+');

my $maxdepth=8;
my @si=(0) x $maxdepth;

while (1) {
  my $str=join('',map {$base[$_].$sv[$si[$_]]} (0..$maxdepth-1)).$base[$maxdepth];
  my $tot=eval($str);
  if ($tot == 100) {
    print "$str\n";
  }
  my $i=0;
  while ($i < $maxdepth) {
    $si[$i]++;
    if ($si[$i] <= $#sv) {
      last;
    }
    $si[$i]=0;
    $i++;
  }
  if ($i >= $maxdepth) {
    last;
  }
}
