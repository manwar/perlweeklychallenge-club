#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(additiveprimes(100),
          [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89],
          'example 1');

sub genprimes {
  my $mx=shift;
  my @primes;
  {
    my %primesh=map {$_ => 1} (2,3);
    for (my $i=6;$i <= $mx+1; $i += 6) {
      foreach my $j ($i-1,$i+1) {
        if ($j <= $mx) {
          $primesh{$j}=1;
        }
      }
    }
    my @q=(2,3,5,7);
    my $p=shift @q;
    my $mr=int(sqrt($mx));
    while ($p <= $mr) {
      if ($primesh{$p}) {
        my $i=$p*$p;
        while ($i <= $mx) {
          delete $primesh{$i};
          $i += $p;
        }
      }
      if (scalar @q < 2) {
        push @q,$q[-1]+4;
        push @q,$q[-1]+2;
      }
      $p=shift @q;
    }
    @primes=sort {$a <=> $b} keys %primesh;
  }
  return \@primes;
}

sub digitsum {
  my $s=0;
  my $x=shift;
  while ($x > 0) {
    $s += $x % 10;
    $x = int($x/10);
  }
  return $s;
}

sub additiveprimes {
  my $mx=shift;
  my @o;
  my %ps;
  foreach my $q (@{genprimes($mx)}) {
    $ps{$q}=1;
    if (exists $ps{digitsum($q)}) {
      push @o,$q;
    }
  }
  return \@o;
}
