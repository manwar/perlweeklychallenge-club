#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub main ( $matrix_json, $k ) {
    my $matrix = decode_json($matrix_json);

    # Check that all rows are the same length
    my $row_length = scalar( @{ $matrix->[0] } );
    foreach my $row (@$matrix) {
        if ( scalar(@$row) != $row_length ) {
            die "All rows must have the same length\n";
        }
    }

    # Flatten the matrix
    my @flattened_list = map { @$_ } @$matrix;

    # Make sure k is between 0 and the one less than the length
    $k = $k % scalar(@flattened_list);

    # Move the last k elements to the front
    splice( @flattened_list, 0, 0, splice( @flattened_list, -$k ) );

    # Rebuild the matrix
    my @new_matrix = ();
    for ( my $i = 0 ; $i <= $#flattened_list ; $i += $row_length ) {
        push @new_matrix, [ @flattened_list[ $i .. $i + $row_length - 1 ] ];
    }

    say '('
        . join( ",\n ",
            map { '[' . join( ', ', @$_ ) . ']' } @new_matrix )
      . ',)';
}

main(@ARGV);
