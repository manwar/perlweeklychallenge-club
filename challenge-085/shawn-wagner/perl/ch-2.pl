#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

# Naive brute force.
sub task2 {
  my $N = shift;
 X:
  for (my $x = 1; $x < $N; $x += 1) {
    for (my $y = 2; $y < $N; $y += 1) {
      my $p = $x ** $y;
      if ($p == $N) {
        say 1;
        return;
      } elsif ($p > $N) {
        next X;
      }
    }
  }
  say 0;
}

task2 8;
task2 15;
task2 125;
