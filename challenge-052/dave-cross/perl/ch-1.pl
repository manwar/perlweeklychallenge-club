#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use File::Basename;

my ($start, $end) = get_params();

for ($start .. $end) {
  say "$_ is a stepping number" if is_stepping($_);
}

sub is_stepping {
  my ($x) = @_;

  my @digits = split //, $x;
  for (0, 1) {
    return if $digits[$_] + 1 != $digits[$_ + 1];
  }
  return 1;
}

sub get_params {
  my $me = basename $0;
  my $usage = "Usage: $me start end\n";
  $usage .= "(where 'start' and 'end' are integers between 100 and 999)\n";

  die $usage if @ARGV < 2;

  for (@ARGV) {
    die $usage if /\D/;
    die $usage if length != 3;
  }

  return sort { $a <=> $b } @ARGV;
}
