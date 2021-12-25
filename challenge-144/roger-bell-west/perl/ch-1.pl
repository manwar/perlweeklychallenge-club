#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(semiprime(100),[4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95],'example 1');

sub semiprime {
  my $mx=shift;
  my $mxx=int($mx/2);
  my @primes;
  {
    my %primesh=map {$_ => 1} (2..$mxx);
    my $p=2;
    while ($p*$p <= $mxx) {
      if ($primesh{$p}) {
        my $i=$p*$p;
        while ($i <= $mxx) {
          delete $primesh{$i};
          $i += $p;
        }
      }
      if ($p==2) {
        $p--;
      }
      $p+=2;
    }
    @primes=sort {$a <=> $b} keys %primesh;
  }
  my %semiprimesh;
  foreach my $i (0..$#primes) {
    foreach my $j ($i..$#primes) {
      my $t=$primes[$i]*$primes[$j];
      if ($t <= $mx) {
        $semiprimesh{$t}=1;
      } else {
        next;
      }
    }
  }
  return [sort {$a <=> $b} keys %semiprimesh];
}
