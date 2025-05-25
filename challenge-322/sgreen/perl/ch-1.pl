#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $input_string, $size ) {
    # Remove existing dashes
    $input_string =~ s/-//g;

    # The start value is the position of the first characters, so the remaining
    #  characters are a multiple of 'size'
    my $start = length($input_string) % $size;
    my @parts = ();

    if ($start) {
        # The first group will be smaller than the rest
        push @parts, substr( $input_string, 0, $start );
    }

    for ( my $pos = $start ; $pos < length($input_string) ; $pos += $size ) {
        # Group the remain characters by size.
        push @parts, substr( $input_string, $pos, $size );
    }

    say join( '-', @parts );
}

main( $ARGV[0], $ARGV[1] );
