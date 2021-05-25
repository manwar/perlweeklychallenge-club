#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0] || 1234;
my $T = sprintf("%b", $N) =~ tr/1//;

do { $N++ }
until ($N == reverse split //,$N) && ((sprintf("%b", $N) =~ tr/1//) == $T+1);
print sprintf("%d => %b\n", $N, $N);
