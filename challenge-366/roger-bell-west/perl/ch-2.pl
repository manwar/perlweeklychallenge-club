#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(validtimes('?2:34'), 3, 'example 1');
is(validtimes('?4:?0'), 12, 'example 2');
is(validtimes('??:??'), 1440, 'example 3');
is(validtimes('?3:45'), 3, 'example 4');
is(validtimes('2?:15'), 4, 'example 5');

sub validtimes($a) {
  my @combinator;
  my @aa = split "", $a;
  while (my ($i, $c) = each @aa) {
    if ($c =~ /[0-9]/) {
      push @combinator, [0 + $c];
    } else {
      if ($i == 0) {
        push @combinator, [0 .. 2];
      } elsif ($i == 1 || $i == 4) {
        push @combinator, [0 .. 9];
      } elsif ($i == 3) {
        push @combinator, [0 .. 5];
      }
    }
  }
  if (scalar @combinator != 4) {
    return 0;
  }
  my $minutes = (scalar @{$combinator[2]}) * (scalar @{$combinator[3]});
  my $ct = 0;
  foreach my $ax (@{$combinator[0]}) {
    foreach my $bx (@{$combinator[1]}) {
      if ($ax * 10 + $bx <= 23) {
        $ct++;
      }
    }
  }
  $ct * $minutes;
}
