#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(homeprime(10),773,'example 1');
is(homeprime(16),31636373,'example 2');

sub genprimes($mx) {
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

sub primefactor($n) {
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

sub homeprime($n0) {
  my $n=$n0;
  while (1) {
    my $t = primefactor($n);
    my @tk = sort {$a <=> $b} keys %{$t};
    if (scalar @tk == 1 && $t->{$tk[0]} == 1) {
      last;
    }
    my $ns = '';
    foreach my $d (@tk) {
      foreach (1..$t->{$d}) {
        $ns .= $d;
      }
    }
    $n = 0 + $ns;
  }
  return $n;
}
