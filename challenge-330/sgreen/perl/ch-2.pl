#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Convert the input string to lowercase, split it into words
    my @words = split / /, lc $input_string;

    # Capitalize the first letter of each word longer than 2 characters
    my @new_words = map { length($_) > 2 ? ucfirst($_) : $_ } @words;

    # Join the words back into a single string with spaces
    say '"', join( ' ', @new_words ), '"';
}

main( $ARGV[0] );
