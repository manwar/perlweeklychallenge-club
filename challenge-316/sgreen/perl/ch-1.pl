#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    foreach my $idx ( 1 .. $#words ) {
        # Check if the first letter of this word is the same as the last
        #  letter of the previous word
        if (
            substr( $words[$idx], 0, 1 ) ne substr( $words[ $idx - 1 ], -1, 1 )
          )
        {
            say 'false';
            return;
        }
    }

    say 'true';
}

main(@ARGV);
