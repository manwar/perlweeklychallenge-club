#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    if ( $input_string !~ /^[0-2?][0-9?]:[0-5?][0-9?]$/ ) {
        die "Input is not in the expected format\n";
    }

    # Compute the hours
    my $hours = 1;
    if ( substr( $input_string, 0, 2 ) eq "??" ) {
        $hours = 24;
    }
    elsif ( substr( $input_string, 0, 1 ) eq "?" ) {
        $hours = substr( $input_string, 1, 1 ) < 4 ? 3 : 2;
    }
    elsif ( substr( $input_string, 1, 1 ) eq "?" ) {
        $hours = substr( $input_string, 0, 1 ) == 2 ? 4 : 10;
    }

    # Compute the minutes
    my $minutes = 1;
    if ( substr( $input_string, 3, 2 ) eq "??" ) {
        $minutes = 60;
    }
    elsif ( substr( $input_string, 3, 1 ) eq "?" ) {
        $minutes = 6;
    }
    elsif ( substr( $input_string, 4, 1 ) eq "?" ) {
        $minutes = 10;
    }

    say $hours * $minutes;
}

main(@ARGV);
