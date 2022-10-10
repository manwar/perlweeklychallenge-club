#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

die "No input\n" if !@ARGV;

for (@ARGV) {
  die "Invalid input $_\n" if /[^a-z0-9]/;
}

my $prefix = '00';

my @out = map { s/^[a-z]+/$prefix++/e; $_ } @ARGV;

say "@out";
