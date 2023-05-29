#!/usr/bin/perl

use strict;
use v5.24;

my @sorted = sort {abs($b) <=> abs($a)} @ARGV;
my $complete;
until ($complete) {
    my $negCount = isNeg($sorted[0]) + isNeg($sorted[1]) + isNeg($sorted[2]);
    if ($negCount == 2 || $negCount == 0) {
        $complete = 1;
    } else {
        my $positives;
        for (2..$#sorted) {
            $positives = 1 if !isNeg($sorted[$_]);
        }
        if ($positives) {
            for (2, 1, 0) {
                if (abs($sorted[$_]) == $sorted[$_]) {
                    next;
                } else {
                    splice (@sorted, $_, 1);
                    last;
                }
            }
        } else {
            say $sorted[-1] * $sorted[-2] * $sorted[-3] and exit;
        }
    }
}
say $sorted[0] * $sorted[1] * $sorted[2];

sub isNeg {
    my $num = shift;
    return $num < 0 ? 1 : 0;
}
