#!/usr/bin/perl
use v5.38;

my @ints = sort { $a <=> $b } @ARGV;
my @output;

while (@ints) {
    push @output, reverse splice @ints, 0, 2;
}

say q{(}, (join q{, }, @output), q{)};
