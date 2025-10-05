#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    my ( $input_string, $char ) = @array;

    # Find the position of the first occurrence of char in input_string
    my $pos = index( $input_string, $char );

    # If char is not found, raise an error
    if ( $pos == -1 ) {
        die "Character '$char' not found in input string.\n";
    }

    # Reverse the first part of the string
    say reverse( substr( $input_string, 0, $pos + 1 ) )
      . substr( $input_string, $pos + 1 );
}

main(@ARGV);
