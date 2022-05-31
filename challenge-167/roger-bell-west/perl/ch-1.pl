#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';
use List::Util qw(max);

use Test::More tests => 2;

is_deeply(cyclicpermute(123),
          [231, 312, 123],
          'example 1');

is_deeply(circular(3,10),
          [113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939,
           199933],
          'example 2');

sub genprimes($mx) {
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

sub cyclicpermute($n) {
  my $ss = $n;
  my @o;
  foreach my $p (1..length($ss)) {
    $ss = substr($ss,1) . substr($ss,0,1);
    push @o,0+$ss;
  }
  return \@o;
}

sub circular($mindigits, $ct) {
  my @o;
  my $base = 1;
  foreach my $p (2..$mindigits) {
    $base *= 10;
  }
  while (scalar @o < $ct) {
    my $pr = genprimes($base * 10);
    my %prs = map {$_ => 1} @{$pr};
    foreach my $cp (@{$pr}) {
      if ($cp >= $base) {
        my $v = 1;
        my $cpp = cyclicpermute($cp);
        foreach my $cpc (@{$cpp}) {
          if (!exists $prs{$cpc}) {
            $v = 0;
            last;
          }
        }
        if ($v) {
          push @o,$cp;
          if (scalar @o >= $ct) {
            last;
          }
          foreach my $cpc (@{$cpp}) {
            delete $prs{$cpc};
          }
        }
      }
    }
    $base *= 10;
  }
  return \@o;
}
