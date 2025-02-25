#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    my $str = shift @words;

    # Turn the words into a regular expression
    my $pattern = '^(' . join( '|', map { quotemeta } @words ) . ')+$';

    # Check if the string matches the pattern
    if ( $str =~ $pattern ) {
        say 'true';
    }
    else {
        say 'false';
    }
}

main(@ARGV);