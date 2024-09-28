#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub closest_palindrome($str) {
    # Negative integers always have a closest palindrome of 0
    if ( $str < 0 ) {
        say 0;
        return;
    }

    my $offset = 1;
    while (1) {
        my $check = $str - $offset;
        if ( $check == reverse($check) ) {
            say $check;
            return;
        }

        $check = $str + $offset;
        if ( $check == reverse($check) ) {
            say $check;
            return;
        }

        $offset++;
    }
}

closest_palindrome( $ARGV[0] );