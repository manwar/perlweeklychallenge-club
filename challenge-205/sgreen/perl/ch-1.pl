#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@n) {
    # Sort the list numerical, removing duplicates
    @n = sort {$a <=> $b} ( uniq(@n) );

    if ( $#n >= 2 ) {
        # There are three or more integers, print the third largest
        say $n[-3];
    }
    else {
        # There are less than three integers, print the largest
        say $n[-1];
    }
}

main(@ARGV);