#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@n) {
    my @solutions = ();

    # Go through the list until it is exhausted
    while ( scalar(@n) ) {
        my $start = my $end = shift @n;

        # See if the next number is one more than the last value
        while ( scalar(@n) > 0 and $n[0] == $end + 1 ) {
            $end = shift @n;
        }

        # We have found a range
        if ( $start != $end ) {
            push @solutions, "[$start,$end]";
        }
    }

    # Print solution
    if (@solutions) {
        say join ', ', @solutions;
    }
    else {
        say 'No solutions found!';
    }
}

main(@ARGV);