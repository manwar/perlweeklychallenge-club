#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';
use List::Util qw(min reduce);

use Test::More tests => 1;

is_deeply(achilles(20),
          [72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968,
           972, 1125, 1152, 1323, 1352, 1372, 1568, 1800],
          'example 1');

sub gcd($m,$n) {
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub genprimes($mx) {
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
  return [sort {$a <=> $b} keys %primesh];
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

sub achilles($ct) {
  my @o;
  my $n = 1;
  while (1) {
    $n++;
    my @pv = values %{primefactor($n)};
    if (scalar @pv > 1 &&
        min(@pv) >= 2 &&
        (reduce {gcd($a,$b)} @pv) == 1) {
      push @o,$n;
      if (scalar @o >= $ct) {
        last;
      }
    }
  }
  return \@o;
}
