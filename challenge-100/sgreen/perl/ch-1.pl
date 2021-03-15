#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $string = lc shift;

    # Split the string with hour, minute and optionally am/pm
    my ( $hour, $minute, $apm ) = ( $string =~ /^(\d+):(\d+)\s*([ap]m)?$/ );
    die "Invalid string\n" unless length($hour) and length($minute);

    # Check the hour value is valid for this format
    if ( $apm and ( $hour < 1 or $hour > 12 ) ) {
        die "Hour must be between 1 and 12\n";
    }
    elsif ( not $apm and $hour > 23 ) {
        die "Hour must be between 0 and 23\n";
    }

    if ($apm) {
        # We need to convert from 12 hour to 24 hour
        $hour = $hour % 12;
        $hour += 12 if $apm eq 'pm';
        say sprintf '%02d:%02d', $hour, $minute;
    }
    else {
        # We convert from 24 hour to 12 hour
        $apm  = $hour >= 12 ? 'pm' : 'am';
        $hour = $hour % 12;
        $hour += 12 if $hour == 0;
        say sprintf '%02d:%02d %s', $hour, $minute, $apm;
    }
}

main(@ARGV);

