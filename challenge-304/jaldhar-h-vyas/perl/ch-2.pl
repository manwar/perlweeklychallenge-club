#!/usr/bin/perl
use v5.38;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my $n = shift;
my @ints = @ARGV;
my $maxAverage = 0;

for my $i (0 .. (scalar @ints - $n)) {
    my $average = sum(@ints[$i .. ($i + $n - 1)]) / $n;
    if ($average > $maxAverage) {
        $maxAverage = $average;
    }
}

say $maxAverage;
