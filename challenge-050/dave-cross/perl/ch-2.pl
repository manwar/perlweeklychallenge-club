#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

die "No input given\n" unless @ARGV;

for my $i (@ARGV) {
  say "$i is a Noble Integer" if scalar (grep { $_ > $i } @ARGV) == $i;
}
