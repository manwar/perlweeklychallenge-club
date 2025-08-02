#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main ($coords) {
    # Determine if a coordinate on a chess board is light

    # Check if the position is valid
    if ( $coords !~ /^[a-h][1-8]$/ ) {
        die "Not a valid chess coordinate!\n";
    }

    my $dark_first = any { substr($coords, 0, 1) eq $_ } ('a','c','e','g');

    if ($dark_first and substr($coords,1,1) % 2 == 0) {
        say 'true';
        return;
    }
    if (not $dark_first and substr($coords,1,1) % 2 == 1) {
        say 'true';
        return;
    }

    say 'false';
}

main($ARGV[0]);