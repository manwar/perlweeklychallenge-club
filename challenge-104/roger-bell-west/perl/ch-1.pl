#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(fuscseq(50),[0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9],'example 1');

use Memoize;

memoize('fusc');

sub fusc {
  my $n=shift;
  if ($n==0) {
    return 0;
  } elsif ($n==1) {
    return 1;
  } elsif ($n%2 == 0) {
    return fusc($n/2);
  } else {
    my $h=($n-1)/2;
    return fusc($h)+fusc($h+1);
  }
}

sub fuscseq {
  my $m=shift;
  return [map {fusc($_)} (0..$m-1)];
}
