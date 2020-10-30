#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use POSIX qw/:limits_h/;
use Config;

BEGIN {
  die "Must be run on a 64-bit perl" unless $Config{use64bitint};
}

sub task1 {
  my $N = shift;
  my $s = reverse $N;
  $s =~ s/(.*)-$/-$1/;
  if ($s > INT_MAX || $s < INT_MIN) {
    say 0;
  } else {
    say $s;
  }
}

task1 4321;
task1 -1234;
task1 "1231230512";
