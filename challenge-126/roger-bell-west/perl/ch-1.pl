#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(cn(15),8,'example 1');
is(cn(25),13,'example 2');
is(cn(10000),6560,'example 3');
is(cn(100000000),43046720,'example 4');

sub cn {
  my $n=shift;
  my $k=$n;
  my @digits;
  while ($k>0) {
    my $d=$k%10;
    if ($d==1) {
      @digits=(8) x scalar(@digits);
    }
    if ($d>0) {
      $d--;
    }
    push @digits,$d;
    $k=int($k/10);
  }
  my $tc=0;
  foreach my $i (reverse(0..$#digits)) {
    $tc*=9;
    $tc+=$digits[$i];
  }
  return $tc;
}
