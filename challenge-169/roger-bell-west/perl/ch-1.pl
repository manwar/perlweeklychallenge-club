#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(brilliant(20),
          [4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121,
           143, 169, 187, 209, 221, 247, 253, 289, 299],
          'example 1');

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

sub brilliant($ct) {
  my $base = 1;
  my %out;
  while (1) {
    my @pl = grep {$_ >= $base} @{genprimes($base * 10)};
    foreach my $ai (0..$#pl) {
      foreach my $bi ($ai..$#pl) {
        $out{ $pl[$ai] * $pl[$bi] } = 1;
      }
    }
    if (scalar keys %out >= $ct) {
      last;
    }
    $base *= 10;
  }
  my @o = sort {$a <=> $b} keys %out;
  splice @o,$ct;
  return \@o;
}
