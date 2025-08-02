#!/usr/bin/perl
use v5.38;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my @matrix = map { [split /\s+/, $_] } @ARGV;
my $specials = 0;

for my $row (keys @matrix) {
    for my $col (keys @{$matrix[$row]}) {
        if (($matrix[$row]->[$col] == 1) &&
        (sum(@{$matrix[$row]}) == 1) &&
        (sum(map { $matrix[$_]->[$col] } keys @matrix) == 1)) {
            $specials++;
        }
    }
}

say $specials;