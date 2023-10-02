#!/usr/bin/perl

use strict;
use v5.24;

my $highest;
foreach (@ARGV) {
    my @words = split(/ /, $_);
    shift @words if !$words[0];
    $highest = scalar @words if scalar @words > $highest;
}
say $highest;
