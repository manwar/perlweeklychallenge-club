#! /usr/bin/perl

use strict;
use warnings;

my $b=$ARGV[0] || '010';

my @res;
my $max=0;

my @b=split '',$b;
foreach my $l (0..$#b) {
  my $la=0;
  if ($l>0) {
    $la=scalar grep /1/,@b[0..$l-1];
  }
  foreach my $r ($l..$#b) {
    my $ma=scalar grep /0/,@b[$l..$r];
    my $ra=0;
    if ($r<$#b) {
      $ra=scalar grep /1/,@b[$r+1..$#b];
    }
    my $a=$la+$ma+$ra;
    if ($a>$max) {
      @res=();
    }
    if ($a>=$max) {
      $max=$a;
      push @res,[$l,$r];
    }
  }
}

foreach my $r (@res) {
  print "(L=$r->[0], R=$r->[1])\n";
}
