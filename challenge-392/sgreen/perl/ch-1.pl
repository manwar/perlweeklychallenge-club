#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Looking for the longest possible palindrome pinned to the start
    for ( my $pos = length($input_string) ; $pos > 1 ; $pos-- ) {
        my $substr = substr( $input_string, 0, $pos );
        if ( $substr eq reverse($substr) ) {
            # Reverse the character at and after pos only
            say '"' .
              reverse( substr( $input_string, $pos ) ) . $input_string . '"';
            return;
        }
    }

    # Reverse all characters except the first one
    say '"' . reverse( substr( $input_string, 1 ) ) . $input_string . '"';
}

main(@ARGV);
