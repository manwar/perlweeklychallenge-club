#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 325 Task 2: Final Price
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( first );

sub final_price( @prices ) {
    return map {
        my $price = $prices[$_];
        my $discount = first { $_ <= $price } @prices[ $_ + 1 .. $#prices ];
        $price - ( $discount // 0 );
    } keys @prices;
}

use Test2::V0 qw( -no_srand );

is [ final_price( 8, 4, 6, 2, 3 ) ], [ 4, 2, 4, 2, 3 ],
    'Example 1: final_price( 8, 4, 6, 2, 3 ) == (4, 2, 4, 2, 3)';
is [ final_price( 1, 2, 3, 4, 5 ) ], [ 1, 2, 3, 4, 5 ],
    'Example 2: final_price( 1, 2, 3, 4, 5 ) == (1 .. 5)';
is [ final_price( 7, 1, 1, 5 ) ], [ 6, 0, 1, 5 ],
    'Example 3: final_price( 7, 1, 1, 5 ) == (6, 0, 1, 5)';
is [ final_price( 3, 4, 7, 5, 8, 2 ) ], [ 1, 2, 2, 3, 6, 2 ],
    'Test 1: final_price( 3, 4, 7, 5, 8, 2 ) == (1, 2, 2, 3, 6, 2)';

done_testing;
