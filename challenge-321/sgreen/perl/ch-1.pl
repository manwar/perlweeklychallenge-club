#!/usr/bin/env perl

use bignum;
use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@numbers) {
    my @averages = ();

    # Make sure the list is even
    if ( $#numbers % 2 == 0 ) {
        die "You must provide an even number of numbers\n";
    }

    # Sort the list, and convert to Decimal type.
    @numbers = sort { $a <=> $b } @numbers;

    foreach my $idx ( 0 .. scalar(@numbers) / 2 - 1 ) {
        # Calculate the unique sums for matching pairs
        push( @averages,
            ( $numbers[$idx] + $numbers[ $#numbers - $idx ] ) / 2 );
    }

    say scalar( uniq @averages );
}

main(@ARGV);
