#!/usr/bin/perl
use 5.030;
use warnings;

my @sorted = sort @ARGV;

say $sorted[-2] * 2 <= $sorted[-1] ? 1 : -1;
