#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';
use JSON;

sub main ($matrix) {
    # Let's define some variables
    my $rows = scalar(@$matrix);
    my $cols = scalar( @{ $matrix->[0] } );

    # We always check from the top left
    my @offsets = ( [ 0, 0 ] );

    # If the matrix isn't square, we also use an offset to hit the bottom right
    if ( $rows > $cols ) {
        push @offsets, [ $rows - $cols, 0 ];
    }
    elsif ( $rows < $cols ) {
        push @offsets, [ 0, $cols - $rows ];
    }

    # The number of checks we need to make
    my $counts = min( $rows, $cols );

   foreach my $o (@offsets) {
        # Define the offsets, and the first value
        my ( $row_offset, $col_offset ) = @$o;
        my $value = $matrix->[$row_offset][$col_offset];

        foreach my $i ( 1 .. $counts - 1 ) {
            # Compare the value until we find one that doesn't match
            if ( $value != $matrix->[ $row_offset + $i ][ $col_offset + $i ] ) {
                say 'false';
                return;
            }
        }
    }

    say 'true';
}

main( decode_json( $ARGV[0] ) );