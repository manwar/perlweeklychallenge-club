#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'product';
use Math::BigInt;

sub main {
    # Set S0 of 2
    my @solutions = ( Math::BigInt->new(2) );

    while ( @solutions < 10 ) {
        # The next value is the product of the current array plus one
        push @solutions, product(@solutions) + 1;
    }

    # Print the solution
    say foreach @solutions;
}

main();