#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 277 Task 2: Strong Pair
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Algorithm::Combinatorics qw( combinations );
use List::Util qw( uniq min );

sub strong_pair( @ints ) {
    return scalar grep
        0 < abs( $_->[0] - $_->[1] ) < min( $_->@[0,1] ),
        combinations( [ uniq( @ints ) ], 2 );
}

sub strong_pair_2( @ints ) {
    return scalar grep
        $_->[0] > $_->[1] && ( $_->[0] - $_->[1] ) < $_->[1]
            || $_->[0] < $_->[1] && ( $_->[1] - $_->[0] ) < $_->[0]
        ? ( 1 ) : (),
        combinations( [ uniq( @ints ) ], 2 );
}


use Test2::V0 qw( -no_srand );

my $sub_name = "strong_pair";
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "Testing $sub:";

    no strict 'refs';
    is $sub->( 1, 2, 3, 4, 5 ), 4,
        'Example 1: $sub( 1, 2, 3, 4, 5 ) == 4';
    is $sub->( 5, 7, 1, 7 ), 1,
        'Example 2: $sub( 5, 7, 1, 7 ) == 1';
}
done_testing;
