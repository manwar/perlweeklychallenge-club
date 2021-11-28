#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @inputs = @_;
    my $sorted = 1;

    for my $i ( 1 .. $#inputs ) {
        # If the value is less than the previous, the array is not sorted
        if ( $inputs[$i] < $inputs[ $i - 1 ] ) {
            $sorted = 0;
            last;
        }
    }

    say $sorted;
}

main(@ARGV);
