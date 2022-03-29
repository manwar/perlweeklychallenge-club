#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(cuban1(1000),
          [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919],
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

sub cuban1 {
  my $mx=shift;
  my @o;
  my %ps=map {$_ => 1} @{genprimes($mx)};
  foreach my $y (1..$mx) {
    my $q=3*$y*($y+1)+1;
    if (exists $ps{$q}) {
      push @o,$q;
    }
  }
  return \@o;
}
