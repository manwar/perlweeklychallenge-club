#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0] || 3;
my $T = sprintf("%b", $N) =~ tr/1//;

do { $N++ } until ((sprintf("%b", $N) =~ tr/1//) == $T);
print sprintf("%d => %b\n", $N, $N);
