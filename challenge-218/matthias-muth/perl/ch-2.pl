#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 218 Task 2: Matrix Score
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( sum );

sub binary_list_to_integer {
    # Reverse the array to have the least significant bit first.
    # Then use the 'b32' format to get 4 bytes of data, with the first one
    # containing the least significant 8 bits. Actually this is VAX order,
    # so unpack it using "V".
    return unpack( "V", pack( "b32", join( "", reverse @_ ) ) );
}

sub matrix_score {
    my ( $matrix ) = @_;
    vsay pp $matrix;

    # First step: Turn the first bits of each row into a '1',
    # by toggling all rows that have '0' as the first bit.
    for my $row ( grep $_->[0] == 0, @$matrix ) {
	$row->[$_] ^= 1
	    for 0..$#$row;
    }
    vsay pp $matrix;

    # Second step: Flip all columns (starting with the second one)
    # that have less ones than zeroes. 
    my $n_columns = scalar @{$matrix->[0]};
    for my $c ( 1 .. $n_columns - 1 ) {
	my $column_sum = sum( map $_->[$c], @$matrix ); 
	if ( $column_sum < $n_columns / 2 ) {
	    $_->[$c] ^= 1
		for @$matrix;
	}
    }
    vsay pp $matrix;

    return sum( map binary_list_to_integer( @$_ ), @$matrix );
}

run_tests;
