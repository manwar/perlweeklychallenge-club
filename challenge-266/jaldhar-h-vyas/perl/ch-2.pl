#!/usr/bin/perl
use v5.38;

sub checkMatrix(@matrix) {
    my $left = 0;
    my $right = scalar @{$matrix[0]} - 1;

    for my $row (keys @matrix) {
        for my $col (keys @{$matrix[$row]}) {
            if ($col == $left || $col == $right) {
                if ($matrix[$row][$col] == 0) {
                    return undef;
                }
            } else {
                if ($matrix[$row][$col] != 0) {
                    return undef;
                }
            }
        }
        $left++;
        $right--;
    }

    return 1;
}

my @matrix = map { [split /\s+/, $_] } @ARGV;
say checkMatrix(@matrix) ? 'true' : 'false';
