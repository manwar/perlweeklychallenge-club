#!/usr/bin/perl

use strict;
use warnings;

my $n = $ARGV[0];
die "ERROR: Missing collatz starting number."    unless defined $n;
die "ERROR: Invalid collatz starting number $n." unless $n > 0;

my @collatz = ($n);
while ($n != 1) {
    $n = ($n % 2 == 0) ? ($n / 2) : ((3 * $n) + 1);
    push @collatz, $n;
}

print sprintf("%s\n", join " -> ", @collatz);
