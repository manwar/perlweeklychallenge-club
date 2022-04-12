#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(moebius(5),-1,'example 1');
is(moebius(10),1,'example 2');
is(moebius(20),0,'example 3');

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

sub primefactor {
  my $n=shift;
  my %f;
  my $m=$n;
  foreach my $p (@{genprimes(int(sqrt($n)))}) {
    while ($m % $p == 0) {
      $f{$p}++;
      $m=int($m/$p);
      if ($m == 1) {
        last;
      }
    }
  }
  if ($m > 1) {
    $f{$m}++;
  }
  return \%f;
}

sub moebius {
  my $n=shift;
  my $z=0;
  foreach my $v (values %{primefactor($n)}) {
    if ($v>1) {
      return 0;
    }
    $z++;
  }
  if ($z % 2 == 0) {
    return 1;
  }
  return -1;
}
