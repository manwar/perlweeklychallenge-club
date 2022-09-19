#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main($phrase) {
# Go through each character
    foreach my $i (0 .. length($phrase)-2) {

        # If the letter in that position does not occur  later, print the index
        if (index($phrase, substr($phrase, $i, 1), $i + 1) == -1) {
            say $i;
            return;
        }
    }

    # Oh dear. Nothing unique!
    say 'No unique characters!';
}

main($ARGV[0]);