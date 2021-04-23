#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    # How many numbers do we want
    my $count = shift // 10;

    # Seed the first row
    my @bell = ( [1] );

    while ( @bell < $count ) {
        my $cols = $#{ $bell[-1] };

        # Create a new row with the last number from the previous row
        push @bell, [ $bell[-1][-1] ];

        # Add each number with the same position from previous row
        foreach my $col ( 0 .. $cols ) {
            push @{ $bell[-1] }, $bell[-2][$col] + $bell[-1][$col];
        }
    }

    # The last number of each row is what we want to show
    say $_->[-1] foreach @bell;
}

main(@ARGV);
