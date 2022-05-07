package main;

use strict;
use warnings;

sub get_summations {
    my @what = @_;

    while ( scalar @what > 1 ) {

        for my $item ( 2 .. scalar @what - 1 ) {
            $what[$item] += $what[ $item - 1 ];
        }

        @what = @what[ 1 .. scalar @what - 1 ];
    }

    return $what[-1];
}

use Test::More;

is( get_summations( 1, 2, 3, 4, 5 ), 42, 'Test 1 2 3 4 5' );
is( get_summations( 1, 3, 5, 7, 9 ), 70, 'Test 1 3 5 7 9' );
is( get_summations(1),               1,  'Test 1' );
is( get_summations( 1, 2 ),          2,  'Test 1 2' );

done_testing;

1;
