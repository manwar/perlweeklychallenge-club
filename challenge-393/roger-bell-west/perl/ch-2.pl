#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(primestep('hello'), 9, 'example 1');
is(primestep('football'), 2, 'example 2');
is(primestep('a'), 0, 'example 3');
is(primestep('challenge'), 2, 'example 4');
is(primestep('perl'), 2, 'example 5');

sub isqrt {
  my $n=shift;
  my $k=$n>>1;
  my $x=1;
  while ($x) {
    my $k1=($k+int($n/$k)) >> 1;
    if ($k1 >= $k) {
      $x=0;
    }
    $k=$k1;
  }
  return $k;
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
  my $mr=isqrt($mx);
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

use List::Util qw(sum min);

sub primestep($a) {
  my $g = sum(map{ord($_)}split '', $a);
  my @pm = @{genprimes($g * 2)};
  my $lo = (grep {$_ <= $g} @pm)[-1];
  my $hi = (grep {$_ > $g} @pm)[0];
  min($g - $lo, $hi - $g);
}
