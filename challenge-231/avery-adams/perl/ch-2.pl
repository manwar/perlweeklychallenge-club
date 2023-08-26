#!/usr/bin/perl
use v5.36;

my $count;
for (@ARGV) {$count++ if substr($_, 11, 2) >= 60}
say $count // 0;
