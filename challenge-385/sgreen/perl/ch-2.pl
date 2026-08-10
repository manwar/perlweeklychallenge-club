#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Check the input string is valid
    if ( $input_string !~ /^[()]+$/ ) {
        die "Invalid input\n";
    }

    my $output     = "";
    my $open_count = 0;

    # Go through each character, increasing open_count as needed. If it is not
    #  1, then it's an inner parentheses and we include it in the output
    foreach my $char ( split //, $input_string ) {
        if ( $char eq "(" ) {
            $open_count++;
        }

        if ( $open_count != 1 ) {
            $output .= $char;
        }

        if ( $char eq ")" ) {
            $open_count--;
        }

        # Check we don't have too many closing parentheses
        if ( $open_count < 0 ) {
            die "Too many closing parentheses\n";
        }
    }

    # Check that we have a matching count of open and closed parentheses.
    if ( $open_count != 0 ) {
        die "Not enough closing parentheses\n";
    }

    say '"' . $output . '"';
}

main(@ARGV);
