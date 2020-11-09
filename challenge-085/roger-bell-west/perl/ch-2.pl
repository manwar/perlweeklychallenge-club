#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(pti(8),1,'example 1');
is(pti(15),0,'example 2');
is(pti(125),1,'example 3');

sub pti {
  my $n=shift;
  my $l=log($n);
  foreach my $ca (2..int(sqrt($n))) {
    my $bg=int($l/log($ca));
    foreach my $cb ($bg,$bg+1) {
      if ($ca ** $cb == $n) {
        return 1;
      }
    }
  }
  return 0;
}
