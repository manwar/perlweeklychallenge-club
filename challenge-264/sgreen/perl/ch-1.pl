#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    my @letters = reverse( 'A' .. 'Z' );
    # Go through each letter in reverse, starting at 'Z'
    foreach my $letter (@letters) {
        if ( index( $str, $letter ) != -1 and index( $str, lc $letter ) != -1 )
        {
            # We have found a match
            say $letter;
            return;
        }
    }

    # There was no match
    say "''";
}

main(@ARGV);