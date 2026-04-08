#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(omega(100061, 0), 3, 'example 1');
is(omega(971088, 0), 3, 'example 2');
is(omega(63640, 1), 6, 'example 3');
is(omega(988841, 1), 2, 'example 4');
is(omega(211529, 0), 2, 'example 5');

use List::Util qw(sum);

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

sub omega($a, $mode) {
  my %pf = %{primefactor($a)};
  if ($mode == 0) {
    return scalar keys %pf;
  } else {
    return sum values %pf;
  }
}
