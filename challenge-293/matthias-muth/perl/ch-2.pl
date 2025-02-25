#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 293 Task 2: Boomerang
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub boomerang( $points ) {
    # Create vectors connecting the points.
    my $v = [ $points->[1][0] - $points->[0][0],
              $points->[1][1] - $points->[0][1] ];
    my $w = [ $points->[2][0] - $points->[1][0],
              $points->[2][1] - $points->[1][1] ];

    # Compute the dot product and the product of the magnitudes
    # (without taking the square root).
    my $dot_product = $v->[0] * $w->[0] + $v->[1] * $w->[1];
    my $mag_product_squared =
        ( $v->[0] ** 2 + $v->[1] ** 2 )
            * ( $w->[0] ** 2 + $w->[1] ** 2 );

    # Compare the two.
    return $dot_product ** 2 != $mag_product_squared;
}


use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

ok boomerang( [[1, 1], [2, 3], [3, 2]] ),
    'Example 1: boomerang( [[1, 1], [2, 3], [3, 2]] ) is true';
ok ! boomerang( [[1, 1], [2, 2], [3, 3]] ),
    'Example 2: boomerang( [[1, 1], [2, 2], [3, 3]] ) is false';
ok boomerang( [[1, 1], [1, 2], [2, 3]] ),
    'Example 3: boomerang( [[1, 1], [1, 2], [2, 3]] ) is true';
ok ! boomerang( [[1, 1], [1, 2], [1, 3]] ),
    'Example 4: boomerang( [[1, 1], [1, 2], [1, 3]] ) is false';
ok ! boomerang( [[1, 1], [2, 1], [3, 1]] ),
    'Example 5: boomerang( [[1, 1], [2, 1], [3, 1]] ) is false';
ok boomerang( [[0, 0], [2, 3], [4, 5]] ),
    'Example 6: boomerang( [[0, 0], [2, 3], [4, 5]] ) is true';
ok ! boomerang( [[1, 1], [2, 1], [1, 1]] ),
    'Extra 1: boomerang( [[1, 1], [2, 1], [1, 1]] ) is false (points 1 and 3 identical)';
ok ! boomerang( [[1, 1], [1, 1], [2, 1]] ),
    'Extra 2: boomerang( [[1, 1], [1, 1], [2, 1]] ) is false (points 1 and 2 identical)';
ok ! boomerang( [[1, 1], [2, 1], [2, 1]] ),
    'Extra 3: boomerang( [[1, 1], [2, 1], [2, 1]] ) is false (points 2 and 3 identical)';
ok ! boomerang( [[1, 1], [1, 1], [1, 1]] ),
    'Extra 4: boomerang( [[1, 1], [1, 1], [1, 1]] ) is false (all points identical)';

done_testing;
