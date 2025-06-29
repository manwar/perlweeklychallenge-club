#!/usr/bin/perl

use strict;
use warnings;
use v5.40;

sub ch_327_2 {
    my @ints = @_;

    local $" = ', ';
    say "Inputs: (@ints)";

    my @all_pairs;
    while (@ints >=2) {
        my $first = shift @ints;
        push @all_pairs, map {[ $first, $_ ]} @ints;
    }

    my $mad;
    for my $p (@all_pairs) {
        my $diff = abs($p->[0] - $p->[1]);
        $mad //= $diff;
        if ($diff < $mad) {
            $mad = $diff;
        }
    }

    say "MAD: $mad";
    say 'Output: ' . join(', ', (
        map {"[@$_]"}
        grep {abs($_->[0] - $_->[1]) == $mad}
        @all_pairs
    ));
    say q();
}

ch_327_2(4, 1, 2, 3);
ch_327_2(1, 3, 7, 11, 15);
ch_327_2(1, 5, 3, 8);
ch_327_2(1, 8, 17, 24);

