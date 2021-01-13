#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use List::Util qw/max/;
use POSIX qw/INT_MIN/;

sub leaders {
  my @A = @_;
  my $rmax = INT_MIN;
  my @maxes = ($rmax);
  for my $i (reverse 0..$#A) {
    $rmax = max $rmax, $A[$i];
    unshift @maxes, $rmax;
  }
  my @leaders;
  for my $i (0 .. $#A) {
    push @leaders, $A[$i] if $A[$i] > $maxes[$i+1];
  }
  if (@leaders) {
    local $, = ", ";
    say "(@leaders)";
  } else {
    say "(0)";
  }
}

leaders 9, 10, 7, 5, 6, 1;
leaders 3, 4, 5;
