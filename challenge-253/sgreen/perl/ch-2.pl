#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util qw(any sum);

sub validate_matrix ($matrix) {
    # Calculate the size of the matrix
    my $rows = scalar(@$matrix);
    my $cols = scalar( @{ $matrix->[0] } );

    foreach my $r ( 0 .. $#$matrix ) {
        # Check that all columns are of equal length
        if ( scalar( @{ $matrix->[$r] } ) != $cols ) {
            die "Row $r has different number of columns\n";
        }

        # Check all values are 0 or 1
        if ( any { $_ != 0 and $_ != 1 } @{ $matrix->[$r] } ) {
            die "Row $r has a value other than 0 or 1\n";
        }

        # Check there are no ones zeros after zero.
        if ( any { $matrix->[$r][ $_ - 1 ] == 0 and $matrix->[$r][$_] == 1 }
            ( 1 .. $cols - 1 ) )
        {
            die "Row $r has a 1 after 0\n";
        }
    }
}

sub weakest_row ($matrix) {
    # Start by validating any issues with the input
    validate_matrix($matrix);

    # Sort by the rows with the most 1s, followed by a numerical sort
    my @sorted = sort {
        sum( @{ $matrix->[$a] } ) <=> sum( @{ $matrix->[$b] } ) || $a <=> $b
    } ( 0 .. $#$matrix );
    return \@sorted;
}

sub main ($json_string) {
    my $matrix = decode_json($json_string);
    my $result = weakest_row($matrix);
    say '(', join( ', ', @$result ), ')';
}

main( $ARGV[0] );