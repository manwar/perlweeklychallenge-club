#! /usr/bin/perl

use strict;
use warnings;

use integer;

while (my $n=shift @ARGV) {
  my @k=($n);
  while ($n != 1) {
    if ($n % 2 == 0) {
      $n/=2;
    } else {
      $n*=3;
      $n++;
    }
    push @k,$n;
  }
  print join(', ',@k),"\n";
}
