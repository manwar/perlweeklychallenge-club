#!/usr/bin/perl
use 5.038;
use warnings;

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

say sum (map { min(split /,/, $_) } @ARGV);