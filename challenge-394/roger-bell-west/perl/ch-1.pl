#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(alternatecase('aAbB'), 0, 'example 1');
is(alternatecase('AAbb'), 1, 'example 2');
is(alternatecase('AAAbbb'), 3, 'example 3');
is(alternatecase('aABb'), 1, 'example 4');
is(alternatecase('bBBAaa'), 2, 'example 5');

sub alternatecase($a) {
  my @uppers = map {($_ =~ /[A-Z]/)?1:0} split '',$a;
  my @queue;
  push @queue,[\@uppers, 0];
  while (scalar @queue > 0) {
    my ($up, $ct) = @{shift @queue};
    my @swaps;
    foreach my $i (0 .. scalar @{$up} - 2) {
      if ($up->[$i] == $up->[$i + 1]) {
        if ($i > 0) {
          push @swaps, $i - 1;
        }
        if ($i < scalar @{$up} - 2) {
          push @swaps, $i + 1;
        }
      }
    }
    if (scalar @swaps == 0) {
      return $ct;
    }
    foreach my $sw (@swaps) {
      my @uq = @{$up};
      ($uq[$sw], $uq[$sw + 1]) = ($uq[$sw + 1], $uq[$sw]);
      push @queue, [\@uq, $ct + 1];
    }
  }
  0;
}
