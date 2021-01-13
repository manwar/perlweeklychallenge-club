#! /usr/bin/perl

use strict;
use warnings;

foreach my $n (@ARGV) {
  my $t=$n;
  while (1) {
    if ($t =~ /^[01]+$/) {
      print "$t\n";
      last;
    } else {
      $t+=$n;
    }
  }
}
