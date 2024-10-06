#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@ints) {
    # Sort the list, removing duplicates
    my @sorted_ints = sort { $b <=> $a } uniq(@ints);

    if ( $#sorted_ints < 2 ) {
        # If there are less than 3 elements, return the largest
        say $sorted_ints[0];
    }
    else {
        # Otherwise, return the third largest
        say $sorted_ints[2];
    }
}
main(@ARGV);