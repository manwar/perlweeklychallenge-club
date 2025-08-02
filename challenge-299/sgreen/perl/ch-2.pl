#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub find_match( $matrix, $word, $positions ) {
    if ( $word eq '' ) {
        # We have a solution
        return 'true';
    }

    # Directions we can move (up, down, left, right)
    my @directions  = ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] );
    my $current_row = $positions->[-1][0];
    my $current_col = $positions->[-1][1];
  D: foreach my $direction (@directions) {
        my $next_row = $current_row + $direction->[0];
        my $next_col = $current_col + $direction->[1];
        if (   $next_row < 0
            or $next_row >= scalar(@$matrix)
            or $next_col < 0
            or $next_col >= scalar( @{ $matrix->[0] } ) )
        {
            # We're out of bounds
            next;
        }

        foreach my $position (@$positions) {
            if ( $position->[0] == $next_row and $position->[1] == $next_col ) {
                # We've already used this position
                next D;
            }
        }

        if ( $matrix->[$next_row][$next_col] eq substr( $word, 0, 1 ) ) {
            # We found a letter at this position. Call the function again to
            #  see if we can find the next letter
            if (
                find_match(
                    $matrix,
                    substr( $word, 1 ),
                    [ @$positions, [ $next_row, $next_col ] ]
                )
              )
            {
                return 1;
            }
        }
    }

    return 0;
}

sub word_search( $matrix, $word ) {
    my $rows = scalar(@$matrix);
    my $cols = scalar( @{ $matrix->[0] } );

    # Check each row has the same number of columns as the first row
    foreach my $row ( 1 .. $#$matrix ) {
        if ( scalar( @{ $matrix->[$row] } ) != $cols ) {
            die "Row $row has the wrong number of columns\n";
        }
    }

    foreach my $row ( 0 .. $rows - 1 ) {
        foreach my $col ( 0 .. $cols - 1 ) {
            if ( $matrix->[$row][$col] eq substr( $word, 0, 1 ) ) {
                if (
                    find_match(
                        $matrix,
                        substr( $word, 1 ),
                        [ [ $row, $col ] ]
                    )
                  )
                {
                    return 1;
                }
            }
        }
    }

    return 0;
}

sub main () {
    # Convert the first value to a list of list of strings
    my $matrix = decode_json( $ARGV[0] );
    my $word   = $ARGV[1];
    my $result = word_search( $matrix, $word );
    say $result ? 'true' : 'false';
}

main();