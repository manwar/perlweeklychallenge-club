#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use JSON 'decode_json';
use List::Util 'none';

sub check_values (@ints) {
    # Check that each number from 1 to the length of ints is present
    for my $i ( 1 .. $#ints + 1 ) {
        if ( none { $_ == $i } @ints ) {
            return 0;
        }
    }

    return 1;
}

sub main ($matrix_json) {
    # Convert JSON into an array of arrays
    my $matrix = decode_json($matrix_json);

    # Check that the matrix is square
    my $length = scalar(@$matrix);

    foreach my $row (@$matrix) {
        if ( scalar(@$row) != $length ) {
            die "All rows must have the same length\n";
        }
    }

    foreach my $i ( 0 .. $#$matrix ) {
        # Check the row is correct
        if ( not check_values( @{ $matrix->[$i] } ) ) {
            say 'false';
            return;
        }

        # Check the column is correct
        if ( not check_values( map { $_->[$i] } @$matrix ) ) {
            say 'false';
            return;
        }
    }

    say 'true';
}

main(@ARGV);
