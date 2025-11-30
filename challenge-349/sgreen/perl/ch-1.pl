#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    my $current_letter = '';
    my $current_length = 0;
    my $max_length     = 0;

    foreach my $letter ( split //, $input_string ) {
        if ( $letter eq $current_letter ) {
            # Increase the length, and update max_length if needed
            $current_length++;
            if ( $current_length > $max_length ) {
                $max_length = $current_length;
            }
        }
        else {
            # Reset for new letter
            $current_letter = $letter;
            $current_length = 1;
        }
    }

    say $max_length;
}

main( $ARGV[0] );
