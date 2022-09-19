#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @solutions = ();
    # Go from 1 to 99.
    foreach my $num ( 1 .. 99 ) {
        # If the sum of the number and the reversed number is all odd...
        if ( ( $num + reverse($num) ) =~ /^[13579]+$/ ) {
            # Add it to the array
            push @solutions, $num;
        }
    }

    say join ', ', @solutions;
}

main();