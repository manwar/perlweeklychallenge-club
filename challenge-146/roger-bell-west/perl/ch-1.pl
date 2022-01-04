#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(nthprime(10001),104743,'example 1');

sub nthprime {
  my $n=shift;
  my $m=15;
  if ($n >= 6) {
    $m=int(1+$n*log($n*log($n)));
  }
  my $primes=genprimes($m);
  return $primes->[$n-1];
}

sub genprimes {
  my $mx=shift;
  my @primes;
  {
    my %primesh=map {$_ => 1} (2,3);
    for (my $i=6;$i <= $mx; $i += 6) {
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
