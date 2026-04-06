#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Check we have a binary string with at least one 1.
    if ( $input_string !~ /^[01]*1[01]*$/ ) {
        die "Input not in expected format\n";
    }

    # Count the number of zeros and ones
    my $zeros = ( $input_string =~ tr/0/0/ );
    my $ones  = ( $input_string =~ tr/1/1/ );

    # Compute the maximum number
    my $output = 1 x ( $ones - 1 ) . "0" x $zeros . "1";
    say $output;
}

main(@ARGV);
