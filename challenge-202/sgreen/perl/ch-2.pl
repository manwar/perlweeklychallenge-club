#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@n) {
    # This stores the current widest (leftmost) valley
    my @solution = ();

    foreach my $valley ( 0 .. $#n ) {
        my $start = my $end = $valley;

        # Get the values to the left that are >= the previous value
        while ( $start > 0 and $n[$start] <= $n[ $start - 1 ] ) {
            $start--;
        }

        # Get the values to the right that are >= the previous value
        while ( $end < $#n and $n[$end] <= $n[ $end + 1 ] ) {
            $end++;
        }

        # If the len of this solution is larger than the previous, it's a
        #  better solution
        if ( scalar(@solution) < $end - $start ) {
            @solution = @n[ $start .. $end ];
        }

    }

    say join ', ', @solution;
}

main(@ARGV);