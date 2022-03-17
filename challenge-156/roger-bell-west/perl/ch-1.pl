#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(pernicious(10),
          [3, 5, 6, 7, 9, 10, 11, 12, 13, 14],
          'example 1');

sub isprime {
  my $candidate=shift;
  if ($candidate<2) {
    return 0;
  } elsif ($candidate==2) {
    return 1;
  } elsif ($candidate==3) {
    return 1;
  } elsif ($candidate % 2 == 0) {
    return 0;
  } elsif ($candidate % 3 == 0) {
    return 0;
  }
  my $anchor=0;
  my $limit=int(sqrt($candidate));
  while (1) {
    $anchor+=6;
    foreach my $t ($anchor-1,$anchor+1) {
      if ($t > $limit) {
        return 1;
      }
      if ($candidate % $t == 0) {
        return 0;
      }
    }
  }
}

sub hammingweight {
  my $x=shift;
  my $count=0;
  while ($x > 0) {
    $x &= ($x-1);
    $count++;
  }
  return $count;
}

sub pernicious {
  my $n=shift;
  my @out;
  my $c=1;
  while (1) {
    if (isprime(hammingweight($c))) {
      push @out,$c;
      if (scalar @out >= $n) {
        last;
      }
    }
    $c++;
  }
  return \@out;
}
