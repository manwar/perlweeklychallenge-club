#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util qw(any max min);

sub main ($matrix) {
    # Calculate the size of the matrix
    my $rows = scalar(@$matrix);
    my $cols = scalar( @{ $matrix->[0] } );

    # Check that all columns are of equal length
    foreach my $r ( 0 .. $#$matrix ) {
        if ( scalar( @{ $matrix->[$r] } ) != $cols ) {
            die "Row $r has different number of columns\n";
        }
    }

    # Calculate the column maximums
    my @column_max = ();
    foreach my $c ( 0 .. $cols - 1 ) {
        push @column_max, max( map { $_->[$c] } @$matrix );
    }

    my $solution = -1;

    # Go through each row
    foreach my $r (@$matrix) {
        # Get the value of all columns that are the minimum value for this row
        #  and the maximum for the column
        my $row_min = min(@$r);
        if ( any { $r->[$_] == $row_min and $column_max[$_] == $row_min }
            ( 0 .. $cols - 1 ) )
        {
            # We have a lucky number (row_min)
            $solution = $row_min;
            last;
        }
    }

    $solution = -1 if not defined $solution;
    say $solution;
}

main(decode_json( $ARGV[0] ) );