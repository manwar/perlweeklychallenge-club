#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub task1 {
  my %nums = map { $_ => 1 } @_;
  for (my $n = 1; ; $n += 1) {
    if (!exists $nums{$n}) {
      say $n;
      return;
    }
  }
}

task1 5, 2, -2, 0;
task1 1, 8, -1;
task1 2, 0, -1;
