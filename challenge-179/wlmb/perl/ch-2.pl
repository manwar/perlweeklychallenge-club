#!/usr/bin/env perl
# Perl weekly challenge 179
# Task 2: Unicode sparkline
#
# See https://wlmb.github.io/2022/08/22/PWC179/#task-2-unicode-sparkline
use v5.36;
use PDL;
use utf8;
binmode STDOUT, ':utf8';
my @blocks=split "", "▁▂▃▄▅▆▇█"; # Array of blocks of different heights
die "Usage: $0 N1 [N2...]\nto make a sparkline with the data N1 N2...\n"
    unless @ARGV;
my $small=1e-7;
my $indices=pdl([@ARGV]);	               # slurp data into ndarray
$indices-=$indices->min;	               # start at 0
$indices*=@blocks/($indices->max+$small);      # Normalize to 0..number of blocks-1
say join "", map {$blocks[$_]} $indices->list; # Use as indices into block array
