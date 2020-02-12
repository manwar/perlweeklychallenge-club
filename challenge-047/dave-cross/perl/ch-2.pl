#!/usr/bin/perl
#
# Write a script to print first 20 Gapful Numbers

use strict;
use warnings;
use feature 'say';

my @gapful;
$_ = 100;

while (@gapful < 20) {
  push @gapful, $_ unless $_ % join '', (split //)[0, -1];
  ++$_;
}

say "@gapful";
