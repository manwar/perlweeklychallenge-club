#! /usr/bin/perl

use strict;
use warnings;

my @stack;

foreach my $i (0..19) {
  if ($i<2) {
    push @stack,1;
  } else {
    push @stack,1+$stack[-1]+$stack[-2];
    shift @stack;
  }
  print $stack[-1],"\n";
}
