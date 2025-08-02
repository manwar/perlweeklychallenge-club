#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::MoreUtils 'first_index';
use List::Util qw(all sum);

sub validate_matrix ($matrix) {
    # Calculate the size of the matrix
    my $rows = scalar(@$matrix);
    my $cols = scalar( @{ $matrix->[0] } );

    foreach my $r ( 1 .. $#$matrix ) {
        # Check that all columns are of equal length
        if ( scalar( @{ $matrix->[$r] } ) != $cols ) {
            die "Row $r has different number of columns\n";
        }
    }
}

sub echelon ($matrix) {
    # Check that the matrix is valid
    validate_matrix($matrix);

    # Get the position of the first one in each row
    my @leading_one = map {
        first_index { $_ == 1 } @$_
    } @$matrix;

    foreach my $row_num ( 0 .. $#$matrix ) {
        my $row             = $matrix->[$row_num];
        my $leading_one_pos = $leading_one[$row_num];

        # If the row is all zeros, there is nothing to check
        if ( all { $_ == 0 } @$row ) {
            next;
        }

        # Check the first non zero number is one
        foreach my $value (@$row) {
            if ( $value == 1 ) {
                last;
            }
            if ( $value != 0 ) {
                return 0;
            }
        }

        # Check if the leading one is further right
        if ( $row_num != 0 ) {
            if ( $leading_one[ $row_num - 1 ] == -1 ) {
                # The previous row was all zeros.
                return 0;
            }
            if ( $leading_one[ $row_num - 1 ] > $leading_one_pos ) {
                # The previous first one was further to the right
                return 0;
            }
        }

        # Count the number of non-zero values in the column that is the
        #  leading one. It should be one (this row)
        if ( scalar( grep { $_->[$leading_one_pos] != 0 } @$matrix ) != 1 ) {
            return 0;
        }
    }

    return 1;
}

sub main ($json_string) {
    my $matrix = decode_json($json_string);
    say echelon($matrix);

}

main( $ARGV[0] );