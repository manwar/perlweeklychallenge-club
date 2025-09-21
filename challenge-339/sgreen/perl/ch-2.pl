#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $current_altitude = 0;
    my $peak             = 0;

    for my $gain (@ints) {
        $current_altitude += $gain;
        if ( $current_altitude > $peak ) {
            $peak = $current_altitude;
        }
    }
    say $peak;
}

main(@ARGV);