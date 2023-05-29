#!/usr/bin/env perl

use strict;
use warnings;
use integer;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util qw(max sum);

sub main ($matrix) {
    my $solution = 0;
    my $cols     = scalar( @{ $matrix->[0] } );
    my $xor_row  = 2**$cols - 1;

    # Convert the matrix into a row of integers
    my @matrix = map { oct( '0b' . join( '', @$_ ) ) } @$matrix;

    foreach my $col_xor ( 0 .. $xor_row ) {
        my @xor_matrix = map { $_ ^ $col_xor } @matrix;
        my $total      = sum( map { max( $xor_row - $_, $_ ) } @xor_matrix );
        if ( $total > $solution ) {
            $solution = $total;
        }
    }

    say $solution;
}

main( decode_json( $ARGV[0] ) );