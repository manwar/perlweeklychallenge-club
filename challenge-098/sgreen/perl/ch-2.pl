#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use 5.12.1;    # each on array

sub main {
    my ( $array, $target ) = @_;
    my @array = ( $array =~ /(-?\d+)/g );

    while ( my ( $idx, $value ) = each @array ) {
        if ( $value >= $target ) {
            # We found an equal or greater value, target is this index
            say $idx;
            return;
        }
    }

    # The target value is greater than all the values. Display $#array + 1
    say scalar(@array);
}

main(@ARGV);
