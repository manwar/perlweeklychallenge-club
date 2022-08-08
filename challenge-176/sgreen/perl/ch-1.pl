#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub sort_number ($num) {
    # Sort the digits numerically. Returns a string
    return join '', sort split //, $num;
}

sub main() {
    my $num = 0;

    # Start incrementing until we have a solution
  N: while ( ++$num ) {
        # The easiest way to see if a number is a permentation of the digits
        #  is to sort it numerically.
        my $sorted_num = sort_number($num);

        foreach my $i ( 2 .. 6 ) {
            # If the product is not a permutation of the number, go to the
            #  next number
            next N if sort_number( $i * $num ) ne $sorted_num;
        }
        # We have a solution
        say $num;
        return;
    }
}

main();