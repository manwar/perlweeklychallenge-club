#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util 'sum';

sub main ($matrix) {
    my $rows             = scalar(@$matrix);
    my $cols             = scalar( @{ $matrix->[0] } );
    my $special_position = 0;

    # The row that has the maximum values
    my $max_row = 0;

    # The number of ones in that row
    my $max_count = 0;

    foreach my $row ( 0 .. $rows - 1 ) {
        # Check this has the same number of columns as the first row
        if ( scalar( @{ $matrix->[$row] } ) != $cols ) {
            die "Row $row has the wrong number of columns\n";
        }

        if ( sum( @{ $matrix->[$row] } ) > $max_count ) {
            $max_row  = $row;
            $max_count = sum( @{ $matrix->[$row] } );
        }
    }
    # Return the rows as a 1-based index value
    say $max_row + 1;
}

main( decode_json( $ARGV[0] ) );