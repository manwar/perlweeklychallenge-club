#!/usr/bin/perl
use v5.38;

my @matrix = map { [split /\s+/, $_] } @ARGV;
my $maxOnes = 0;
my $maxRow = 0;

for my $row (keys @matrix) {
    my $ones = scalar grep { $_ == 1 } @{$matrix[$row]};
    if ($ones > $maxOnes) {
        $maxOnes = $ones;
        $maxRow = $row + 1;
    }
}

say $maxRow;
