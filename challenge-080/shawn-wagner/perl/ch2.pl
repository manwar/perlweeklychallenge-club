#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub task2 {
  my $candies = @_;
  for (my $n = 0; $n <= $#_; $n += 1) {
    if (($n > 0 && $_[$n] > $_[$n - 1]) ||
        ($n < $#_ && $_[$n] > $_[$n + 1])) {
      $candies += 1;
    }
  }
  say $candies;
}

task2 1, 2, 2;
task2 1, 4, 3, 2;
