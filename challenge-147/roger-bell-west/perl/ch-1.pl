#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(ltruncprimes(20),[2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197],'example 1');

sub ltruncprimes {
  my $count=shift;
  my @out;
  my $lt=0;
  my @p=@{genprimes(500)};
  my %p=map {$_ => 1} @p;
  foreach my $pc (@p) {
    my $l=length($pc);
    my $c=1;
    foreach my $i (1..$l-1) {
      unless (exists $p{substr($pc,$i,$l+1-$i)}) {
        $c=0;
        last;
      }
    }
    if ($c) {
      push @out,$pc;
      $lt++;
      if ($lt >= $count) {
        last;
      }
    }
  }
  return \@out;
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
