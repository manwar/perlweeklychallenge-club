#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(fuscseq(50),[0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9],'example 1');

sub fusc($n) {
  state %cache;
  if (%cache{$n}:exists) {
    return %cache{$n};
  }
  my $m;
  if ($n==0) {
    $m=0;
  } elsif ($n==1) {
    $m=1;
  } elsif ($n%2 == 0) {
    $m=fusc($n/2);
  } else {
    my $h=($n-1)/2;
    $m=fusc($h)+fusc($h+1);
  }
  %cache{$n}=$m;
  return $m;
}

sub fuscseq($m) {
  return [map {fusc($_)},(0..$m-1)];
}
