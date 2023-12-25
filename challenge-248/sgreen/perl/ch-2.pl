#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub main ($matrix) {
    # Calculate the size of the matrix
    my $cols = scalar( @{ $matrix->[0] } );

    # Check that all columns are of equal length
    foreach my $r ( 1 .. $#$matrix ) {
        if ( scalar( @{ $matrix->[$r] } ) != $cols ) {
            die "Row $r has different number of columns\n";
        }
    }

    say '[';
    foreach my $r ( 0 .. $#$matrix - 1) {
        # Compute each row
        my @row = ();
        foreach my $c ( 0 .. $cols - 2 ) {
            push @row,
              $matrix->[$r][$c] +
              $matrix->[$r][ $c + 1 ] +
              $matrix->[ $r + 1 ][$c] +
              $matrix->[ $r + 1 ][ $c + 1 ];
        }
        say '  [', join( ', ', @row ), '],';
    }
    say ']';
}

main( decode_json( $ARGV[0] ) );