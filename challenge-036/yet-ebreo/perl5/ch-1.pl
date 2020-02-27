#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

if (@ARGV != 1) {
    say "Usage:\n\tperl ch-1.pl <VIN>\n\n";
} else {
    my $vin = $ARGV[0];
    if ($vin =~ /[OIQ]/i) {
        say "Invalid VIN";
    } else {
        if ($vin =~ /^[A-Z0-9]{17}$/i) {
            say "VIN is valid";
        } else {
            say "Invalid VIN";
        }
    }
}