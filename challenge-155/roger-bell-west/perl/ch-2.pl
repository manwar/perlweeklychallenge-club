#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(pisano(3),8,'example 1');
is(pisano(6),24,'example 2');

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
  foreach my $p (2,3,5,7) {
    while ($m % $p == 0) {
      $f{$p}++;
      $m=int($m/$p);
    }
  }
  if ($m > 1) {
    foreach my $p (@{genprimes($m)}) {
      while ($m % $p == 0) {
        $f{$p}++;
        $m=int($m/$p);
        if ($m == 1) {
          last;
        }
      }
    }
  }
  return \%f;
}

sub gcd {
  my ($m,$n)=@_;
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub lcm {
  my ($m,$n)=@_;
  return $m/gcd($m,$n)*$n;
}

sub pisano {
  my $n=shift;
  my $a=1;
  my $f=primefactor($n);
  foreach my $nn (map {$_ ** $f->{$_}} keys %{$f}) {
    my $t=1;
    my @x=(1,1);
    while ($x[0]!=0 || $x[1] != 1) {
      $t++;
      @x=($x[1],($x[0]+$x[1]) % $nn);
    }
    $a=lcm($a,$t);
  }
  return $a;
}
