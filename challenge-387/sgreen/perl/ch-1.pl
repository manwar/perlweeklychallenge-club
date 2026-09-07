#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Check the input is valid
    if ( $input_string !~ /^[01]+$/ ) {
        die "Invalid input\n";
    }

    # Count the number times we swap '01' with '10'
    my $count = 0;
    while ( index( $input_string, "01" ) != -1 ) {
        $count++;
        $input_string =~ s/01/10/g;
    }

    say $count;
}

main(@ARGV);
