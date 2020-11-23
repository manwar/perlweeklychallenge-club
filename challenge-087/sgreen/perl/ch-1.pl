#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

sub main {
    my @N       = @_;
    my @largest = ();
    my @current = ();

    # Check that we have integers
    die "You must specify one or more integers\n" unless scalar(@N);
    foreach (@N) {
        die "The value '$_' does not appear to be an integer\n"
          unless /^-?\d+$/;
    }

    # Go through the sorted list of numbers
    foreach my $n ( sort { $a <=> $b } @N ) {
        if ( scalar(@current) and $current[-1] != $n - 1 ) {
            # Reset the array if the last number is not $n - 1
            @current = ();
        }

        push @current, $n;
        if ( scalar(@current) > scalar(@largest) ) {
            @largest = @current;
        }
    }

    if ( scalar(@largest) > 1 ) {
        say 'Output: (', join( ', ', @largest ), ')';
    }
    else {
        say 'Output: 0';
    }
}

main(@ARGV);
