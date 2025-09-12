#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub point_score ( $row, $col, $point ) {
    if ( $row == $point->[0] && $col == $point->[1] ) {
        return 2;
    }
    if ( $row == $point->[0] || $col == $point->[1] ) {
        return 1;
    }
    return 0;
}

sub main (@ints) {
    my $rows   = shift @ints;
    my $cols   = shift @ints;
    my @points = ();
    for ( my $i = 0 ; $i < $#ints ; $i += 2 ) {
        push @points, [ $ints[$i], $ints[ $i + 1 ] ];
    }

    my $odd_cells = 0;

    foreach my $row ( 0 .. $rows - 1 ) {
        foreach my $col ( 0 .. $cols - 1 ) {
            # Calculate the score for this cell
            my $score = 0;
            foreach my $point (@points) {
                $score += point_score( $row, $col, $point );
            }

            # If the score is odd, increment the count of odd cells
            if ( $score % 2 == 1 ) {
                $odd_cells++;
            }
        }
    }

    say $odd_cells;
}

main(@ARGV);
