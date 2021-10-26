#! /usr/bin/perl

use strict;

use Test::More tests => 5;

is(sedolv('2936921'),1,'example 1');
is(sedolv('1234567'),0,'example 2');
is(sedolv('B0YBKL9'),1,'example 3');
is(sedolv('A0ZBKL9'),0,'example 4');
is(sedolv('B2YBIL9'),0,'example 5');

sub sedolv {
  my $sedol=shift;
  my @w=(1,3,1,7,3,9,1);
  if (length($sedol) != 7) {
    return 0;
  }
  my $s=0;
  foreach my $i (0..6) {
    my $c=substr($sedol,$i,1);
    my $n=0;
    if ($c =~ /[0-9]/) {
      $n=$c+0;
    } elsif ($c =~ /[B-Z]/ && $c !~ /[EIOU]/) {
      $n=ord($c)-55;
    } else {
      return 0;
    }
    $s+=$n*$w[$i];
  }
  if ($s % 10 == 0) {
    return 1;
  }
  return 0;
}
