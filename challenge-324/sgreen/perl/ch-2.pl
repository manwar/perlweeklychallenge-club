#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics qw(combinations);

sub main (@ints) {
    my $total = 0;
    foreach my $i ( 1 .. scalar(@ints) ) {
        # Generate all combinations of length i
        # and calculate the XOR for each combination
        my $combination = combinations( \@ints, $i );
        while ( my $combo = $combination->next ) {
            my $xor_value = 0;
            foreach my $num (@$combo) {
                $xor_value ^= $num;
            }
            $total += $xor_value;
        }
    }

    say $total;
}

main(@ARGV);
