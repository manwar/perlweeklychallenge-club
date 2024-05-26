#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub main ($matrix) {
    my $rows             = scalar(@$matrix);
    my $cols             = scalar( @{ $matrix->[0] } );
    my $special_position = 0;

    # Count the number of ones in each row and column
    my @row_count = ( (0) x $rows );
    my @col_count = ( (0) x $cols );

    foreach my $row ( 0 .. $rows - 1 ) {
        # Check this has the same number of columns as the first row
        if ( scalar( @{ $matrix->[$row] } ) != $cols ) {
            die "Row $row has the wrong number of columns\n";
        }

        foreach my $col ( 0 .. $cols - 1 ) {
            if ( $matrix->[$row][$col] ) {
                $row_count[$row]++;
                $col_count[$col]++;
            }
        }
    }

    # Find the number of special positions. This is true if the value is one
    #  and the row_count and col_count is one
    foreach my $row ( 0 .. $rows - 1 ) {
        foreach my $col ( 0 .. $cols - 1 ) {
            if (    $matrix->[$row][$col]
                and $row_count[$row] == 1
                and $col_count[$col] == 1 )
            {
                $special_position++;
            }
        }
    }

    say $special_position;
}

main( decode_json( $ARGV[0] ) );