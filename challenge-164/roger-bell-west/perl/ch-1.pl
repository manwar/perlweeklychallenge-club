#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(primepal(1000),[2, 3, 5, 7, 11, 101, 131, 151, 181, 191,
                          313, 353, 373, 383, 727, 757, 787, 797, 919,
                          929],'example 1');

sub isnumpal {
  my $c0 = shift;
  my $c = $c0;
  my $j = 0;
  while ($c > 0) {
    $j = 10 * $j + $c % 10;
    $c = int($c/10);
  }
  return ($c0 == $j);
}

sub primepal {
  my $pmax = shift;
  return [grep {isnumpal($_)}  @{genprimes($pmax)}];
}

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

sub sumbitwise {
  my $ls = shift;
  my $iter = combinations($ls,2);
  my $s = 0;
  while (my $c = $iter->next) {
    $s += $c->[0] & $c->[1];
  }
  return $s;
}
