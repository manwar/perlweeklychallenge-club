#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

for my $in (@ARGV) {
  my $x = 0;

  for (0 .. length($in) - 1) {
    if (substr($in, $_, 1) =~ /[a-z0-9]/) {
      substr $in, $_, 1, 'x';
      ++$x;
    }

    last if $x == 4;
  }

  say $in;
}
