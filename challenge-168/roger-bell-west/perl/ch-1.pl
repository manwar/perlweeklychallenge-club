#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(perrinprime(13),
          [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721,
           1442968193, 792606555396977],
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

sub perrinprime($n) {
  my %out;
  my @seq = (3, 0, 2);
  while (1) {
    push @seq,$seq[0]+$seq[1];
    shift @seq;
    if (isprime($seq[-1])) {
      $out{$seq[-1]} = 1;
      if (scalar keys %out >= $n) {
        last;
      }
    }
  }
  return [sort {$a <=> $b} keys %out];
}
