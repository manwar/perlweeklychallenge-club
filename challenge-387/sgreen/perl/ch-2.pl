#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub expand_parens( $inner, $multiplier ) {
    # Expand the inner parentheses

    # Go through each element, applying the multiplier to each one
    my %new_elements = ();
    while ( $inner =~ /([A-Z][a-z]?)(\d+)?/g ) {
        $new_elements{$1} += $multiplier * ( $2 // 1 );
    }

    return join( "", map { "$_$new_elements{$_}" } keys %new_elements );
}

sub main ($input_string) {
    # Keep expanding inner parentheses while there is still some
    while ( $input_string =~ /\([A-Z0-9]+\)\d+/i ) {
        $input_string =~ s/\(([A-Z0-9]+)\)(\d+)/expand_parens($1, $2)/ieg;
    }

    # Check that the final string is as expected
    if ( $input_string !~ /^[A-Z0-9]+$/i ) {
        die "Invalid input\n";
    }

    # Count the number of atoms each element has
    my %count_elements = ();
    while ( $input_string =~ /([A-Z][a-z]?)(\d+)?/g ) {
        $count_elements{$1} += ($2 // 1);
    }

    # Generate the output, sorted by the element alphabetically
    my $output = "";
    foreach my $element ( sort keys %count_elements ) {
        my $count = $count_elements{$element};
        $output .= $element;
        if ( $count > 1 ) {
            $output .= $count;
        }
    }

    say $output;
}

main(@ARGV);
