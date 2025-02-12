#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my @sorted = sort { $a <=> $b }  @ints;
my @diffs;

for my $i (keys @ints) {
    if ($ints[$i] != $sorted[$i]) {
        push @diffs, $i;
    }
}

say q{(}, (join q{, }, @diffs), q{)};
