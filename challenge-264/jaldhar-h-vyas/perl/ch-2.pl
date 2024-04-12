#!/usr/bin/perl
use 5.030;
use warnings;

my @sources = split /\s+/, $ARGV[0];
my @indices = split /\s+/, $ARGV[1];
my @output;

for my $i (keys @sources) {
    splice @output, $indices[$i], 0, $sources[$i];
}

say q{(}, (join q{, }, @output), q{)};
