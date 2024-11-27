#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'true';

sub double_exists(@ints) {
    # Iterate through list
    foreach my $i (@ints) {
        # If a value twice this value exists
        if ( grep { $i * 2 == $_ } @ints ) {
            # ... and it is not zero, or zero appears at least twice
            if ( $i != 0 or ( true { $_ == 0 } @ints ) > 1 ) {
                say 'true';
                return;
            }
        }
    }

    # No values twice another value exists
    say 'false';
}

double_exists(@ARGV);