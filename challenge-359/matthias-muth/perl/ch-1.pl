#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 359 Task 1: Digital Root
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub digital_root( $int ) {
    my $persistence = 0;
    ( $int = sum( split //, $int ), ++$persistence )
        while $int > 9;
    return ( $persistence, $int );
}

use Test2::V0 qw( -no_srand );

is [ digital_root( 38 ) ], [ 2, 2 ],
    'Example 1: digital_root( 38 ) => ( 2, 2 )';
is [ digital_root( 7 ) ], [ 0, 7 ],
    'Example 2: digital_root( 7 ) => ( 0, 7 )';
is [ digital_root( 999 ) ], [ 2, 9 ],
    'Example 3: digital_root( 999 ) => ( 2, 9 )';
is [ digital_root( 1999999999 ) ], [ 3, 1 ],
    'Example 4: digital_root( 1999999999 ) => ( 3, 1 )';
is [ digital_root( 101010 ) ], [ 1, 3 ],
    'Example 5: digital_root( 101010 ) => ( 1, 3 )';

done_testing;
