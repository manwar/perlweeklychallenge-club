#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main (@ints) {
    # Record all the loops we find
    my $loops = 0;

  F: foreach my $first ( 0 .. $#ints ) {
        my @loop = ();
        my $pos  = $first;

        while ( $pos >= 0 and $pos <= $#ints and defined( $ints[$pos] ) ) {
            push @loop, $pos;

            # What is the next number
            my $next_pos = $ints[$pos];

            # Mark this position as used
            $ints[$pos] = undef;

            if ( any { $next_pos == $_ } @loop ) {
                # We have a loop
                ++$loops;
                next F;
            }

            # Continue with the next position
            $pos = $next_pos;
        }
    }

    # Print the loops we found
    say $loops;
}

main(@ARGV);