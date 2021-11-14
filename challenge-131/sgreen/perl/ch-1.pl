#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(notall uniq);
use feature 'say';

sub main {
    my @N = @_;

    # Sanity check
    die "You must specify one or more numbers\n" unless @N;
    die "Not all values are postive integers\n" if notall { /^[1-9][0-9]*$/ } @N;

    # Sort and uniquify the list
    @N = uniq( sort { $a <=> $b } @N );

    my @output = ( [ shift @N ] );

    while (@N) {
        # Grab the next number
        my $number = shift @N;

        if ( $number == $output[-1][-1] + 1 ) {
            # The value is part of the existing sequence
            push @{ $output[-1] }, $number;
        }
        else {
            # The number starts a new sequence
            push @output, [$number];
        }
    }

    # Display the results
    say '(', join( ', ', map { '[' . join( ', ', @$_ ) . ']' } @output ), ')';
}

main(@ARGV);
