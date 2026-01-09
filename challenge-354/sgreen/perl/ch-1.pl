#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    @ints = sort { $a <=> $b } @ints;
    my $min_abs_diff = undef;
    my @result = ();

    foreach my $i (0..$#ints-1) {
        my $abs_diff = $ints[$i + 1] - $ints[$i];
        if (not defined $min_abs_diff or $abs_diff < $min_abs_diff) {
            $min_abs_diff = $abs_diff;
            @result = ( [ $ints[$i], $ints[$i + 1] ] );
        }
        elsif ($abs_diff == $min_abs_diff) {
            push @result, [ $ints[$i], $ints[$i + 1] ];
        }
    }

    say join(", ", map { "[$_->[0], $_->[1]]" } @result);
}

main(@ARGV);