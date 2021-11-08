#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

say oct('0b' . (join '', map {my $rev = reverse substr(sprintf("%08b", $ARGV[0] & 255), 2*$_,2)} (0..3)))
