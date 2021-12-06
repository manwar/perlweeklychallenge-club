#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(divisors(8,10),[24,30,40,42,54,56,66,70,78,88],'example 1');

sub factorcount {
  my $n=shift;
  if ($n==1) {
    return 1;
  }
  my $f=2;
  my $s=int(sqrt($n));
  if ($s*$s == $n) {
    $s--;
    $f++;
  }
  foreach my $pf (2..$s) {
    if ($n % $pf == 0) {
      $f+=2;
    }
  }
  return $f;
}

sub divisors {
  my ($count,$n)=@_;
  my $nn=$n;
  my @a;
  my $t=0;
  while ($nn) {
    $t++;
    if (factorcount($t)==$count) {
      push @a,$t;
      $nn--;
    }
  }
  return \@a;
}
