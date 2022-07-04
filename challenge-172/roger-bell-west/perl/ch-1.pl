#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;
use Math::Prime::Util qw(primes);
use List::Util qw(sum);

is_deeply(primepartition(18, 2),
          [13, 5],
          'example 1');

is_deeply(primepartition(19, 3),
          [11, 5, 3],
          'example 2');

sub primepartition($n, $divs) {
  my @pl = @{primes($n)};
  my @p = ([]);
  while (scalar @p > 0) {
    my $pa = pop @p;
    if (scalar @{$pa} == $divs) {
      if (sum(@{$pa}) == $n) {
        return $pa;
      }
    } else {
      my %px = map {$_ => 1} @{$pa};
      foreach my $pq (@pl) {
        unless (exists $px{$pq}) {
          push @p,[@{$pa},$pq];
        }
      }
    }
  }
  return [$n];
}
