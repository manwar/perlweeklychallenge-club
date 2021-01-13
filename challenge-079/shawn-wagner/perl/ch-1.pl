#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

# Optionally use Bit::Fast version of popcount

BEGIN {
    eval {
        require Bit::Fast;
        Bit::Fast->import(qw/popcount/);
    } or eval {
        sub popcount {
            # Quick and dirty alternative population count
            my $binary = unpack "b*", pack("i", $_[0]);
            return $binary =~ tr/1/1/;
        }
    }
}

sub task1 :prototype($) {
  my $total = 0;
  for my $n (1 .. $_[0]) {
      my $bits = popcount $n;
      $total += $bits;
  }
  say $total % 1000000007;
}

task1 4;
task1 3;
