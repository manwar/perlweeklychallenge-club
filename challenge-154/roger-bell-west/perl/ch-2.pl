#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(padovanprime(10),
          [2,3,5,7,37,151,3329,23833,13091204281,3093215881333057],
          'example 1');

sub padovanprime {
  my $ct=shift;
  my %pp;
  my @padovans=(1,1,1);
  while (1) {
    push @padovans,$padovans[0]+$padovans[1];
    shift @padovans;
    if (isprime($padovans[-1])) {
      $pp{$padovans[-1]}=1;
      if (scalar keys %pp >= $ct) {
        last;
      }
    }
  }
  return [sort {$a <=> $b} keys %pp];
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
