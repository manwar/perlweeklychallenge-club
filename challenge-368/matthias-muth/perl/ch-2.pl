#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 368 Task 2: Big and Little Omega
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Math::Prime::Util qw( factor );
use List::Util qw( uniq );

sub big_and_little_omega( $number, $mode ) {
    return
        $mode == 1
        ? scalar factor( $number )
        : scalar uniq factor( $number );
}

use Test2::V0 qw( -no_srand );

is big_and_little_omega( 100061, 0 ), 3,
    'Example 1: big_and_little_omega( 100061, 0 ) == 3';
is big_and_little_omega( 971088, 0 ), 3,
    'Example 2: big_and_little_omega( 971088, 0 ) == 3';
is big_and_little_omega( 63640, 1 ), 6,
    'Example 3: big_and_little_omega( 63640, 1 ) == 6';
is big_and_little_omega( 988841, 1 ), 2,
    'Example 4: big_and_little_omega( 988841, 1 ) == 2';
is big_and_little_omega( 211529, 0 ), 2,
    'Example 5: big_and_little_omega( 211529, 0 ) == 2';

done_testing;
