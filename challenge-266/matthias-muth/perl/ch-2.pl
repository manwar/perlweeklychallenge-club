#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 266 Task 2: X Matrix
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub x_matrix( $matrix ) {
    for my $i ( 0..$matrix->$#* ) {
	for my $j ( 0..$matrix->$#* ) {
	    return 0
		if ( ( $i == $j || $i == $matrix->$#* - $j )
		    xor $matrix->[$i][$j] != 0 );
	}
    }
    return 1;
}

use Test2::V0 qw( -no_srand );
ok x_matrix( [[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]] ),
    'Example 1: x_matrix( [[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]] ) is true';
ok ! x_matrix( [[1, 2, 3], [4, 5, 6], [7, 8, 9]] ),
    'Example 2: x_matrix( [[1, 2, 3], [4, 5, 6], [7, 8, 9]] ) is false';
ok x_matrix( [[1, 0, 2], [0, 3, 0], [4, 0, 5]] ),
    'Example 3: x_matrix( [[1, 0, 2], [0, 3, 0], [4, 0, 5]] ) is true';
done_testing;
