#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;
use List::Util qw(max);

is_deeply(fortunate(8),
          [3, 5, 7, 13, 17, 19, 23, 37],
          'example 1');

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

sub isprime {
  my $candidate=shift;
  if ($candidate==2) {
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

sub nthprimelimit {
  my $n=shift;
  my $m=15;
  if ($n >= 6) {
    $m=int(1+$n*log($n*log($n)));
  }
  return $m;
}

sub fortunate {
  my $ct=shift;
  my %o;
  my @ll;
  my $ph=1;
  foreach my $p (@{genprimes(nthprimelimit($ct*2))}) {
    if (scalar keys %o >= $ct) {
      if ($p >= max(keys %o)) {
        last;
      }
    }
    $ph *= $p;
    my $l=$p+1;
    while (!isprime($l+$ph)) {
      $l++;
    }
    $o{$l}=1;
    if (scalar keys %o > $ct) {
      @ll=sort {$a <=> $b} keys %o;
      splice @ll,$ct;
      %o=map {$_ => 1} @ll;
    }
  }
  return \@ll;
}
