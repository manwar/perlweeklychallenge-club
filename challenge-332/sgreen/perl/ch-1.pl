#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Split the input string by hyphens
    my @date_parts = split /-/, $input_string;

    # Convert each part to binary and remove the '0b' prefix
    my @binary_parts = map { sprintf( "%b", $_ ) } @date_parts;

    # Join the binary parts with hyphens
    say join( '-', @binary_parts );
}

main( $ARGV[0] );
