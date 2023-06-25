#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;
my @sorted = sort { $a <=> $b} @ints;
my $matches = 0;

for my $i (0 .. scalar @ints - 1) {
    if ($ints[$i] == $sorted[$i]) {
        $matches++;
    }
}

say $matches;