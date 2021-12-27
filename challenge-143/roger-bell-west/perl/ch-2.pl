#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(is_stealthy(36),1,'example 1');
is(is_stealthy(12),1,'example 2');
is(is_stealthy(6),0,'example 3');

sub factorpairs {
  my $n=shift;
  if ($n==1) {
    return [2];
  }
  my @ff;
  my $s=int(sqrt($n));
  if ($s*$s == $n) {
    push @ff,$s*2;
    $s--;
  }
  foreach my $pf (2..$s) {
    if ($n % $pf == 0) {
      push @ff,$pf+$n/$pf;
    }
  }
  push @ff,1+$n;
  return \@ff;
}

sub is_stealthy {
  my $n=shift;
  my $p=factorpairs($n);
  if (scalar @{$p}==1) {
    return 0;
  }
  foreach my $ix (0..scalar @{$p}-2) {
    foreach my $iy ($ix+1..scalar @{$p}-1) {
      if (abs($p->[$ix]-$p->[$iy])==1) {
        return 1;
      }
    }
  }
  return 0;
}
