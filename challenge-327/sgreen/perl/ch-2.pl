#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    @ints = sort { $a <=> $b} @ints;

    my $min_diff = undef;
    my @min_diff_pairs = ();
    foreach my $i (0 .. $#ints-1) {
        my $diff = $ints[$i + 1] - $ints[$i];
        if (not defined $min_diff or $diff < $min_diff) {
            $min_diff = $diff;
            @min_diff_pairs = ();
        }
        if ($diff == $min_diff) {
            push @min_diff_pairs, [$ints[$i], $ints[$i + 1]];
        }
    }

    say join(', ', map { "[$_->[0], $_->[1]]" } @min_diff_pairs);
}

main(@ARGV);