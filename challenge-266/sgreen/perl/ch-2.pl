#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub main ($matrix) {
    my $rows = scalar(@$matrix);

    # Check we have a square
    foreach my $row ( 0 .. $#$matrix ) {
        if ( scalar( @{ $matrix->[$row] } ) != $rows ) {
            die "Please specify a square matrix\n";
        }
    }

    # Check that all the values are correct
    my $is_x_matrix = 1;
  MATRIX: foreach my $row ( 0 .. $#$matrix ) {
        foreach my $col ( 0 .. $#$matrix ) {
            if ( $col == $row or $col == $rows - 1 - $row ) {
                # We are expecting a non-zero value
                if ( $matrix->[$row][$col] == 0 ) {
                    $is_x_matrix = 0;
                    last MATRIX;
                }
            }
            # We are expecting a zero value
            elsif ( $matrix->[$row][$col] != 0 ) {
                $is_x_matrix = 0;
                last MATRIX;
            }
        }
    }

    say $is_x_matrix ? 'true' : 'false';
}

main( decode_json( $ARGV[0] ) );