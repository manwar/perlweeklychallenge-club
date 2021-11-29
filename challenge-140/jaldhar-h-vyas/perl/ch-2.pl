#!/usr/bin/perl
use 5.020;
use warnings;

if (scalar @ARGV != 3) {
    die "need three integers.\n";
}

my @table;

for my $i (1 .. $ARGV[0]) {
    for my $j (1 .. $ARGV[1]) {
        push @table, $i * $j;
    }
}

say 0+(sort { $a <=> $b } @table)[$ARGV[2] - 1]; 
