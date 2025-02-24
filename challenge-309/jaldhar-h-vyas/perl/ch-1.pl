#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my %diffs;
for my $i (1 .. scalar @ints - 1) {
    push @{ $diffs{ $ints[$i] - $ints[$i - 1] } }, $ints[$i];
}

say @{ $diffs{ (sort { $a <=> $b } keys %diffs)[0] } }[0];
