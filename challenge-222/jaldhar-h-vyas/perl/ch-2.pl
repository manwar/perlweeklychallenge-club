#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;

my @sorted = sort { $b <=> $a } @ints;

until (scalar @sorted < 2) {
    if ($sorted[0] == $sorted[1]) {
        @sorted = sort { $b <=> $a } splice @sorted, 2;
    } else {
        my $new = $sorted[0] - $sorted[1];
        @sorted = splice @sorted, 2;
        push @sorted, $new;
        @sorted = sort { $b <=> $a } @sorted;
    }
}

say scalar @sorted ? $sorted[0] : 0;
