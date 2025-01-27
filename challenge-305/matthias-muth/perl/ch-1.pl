#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 305 Task 1: Binary Prefix
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Math::Prime::Util qw( is_prime );

sub binary_prefix( @binary ) {
    my $n = 0;
    return map { $n = $n << 1 | $_; $n == 2 || $_ && is_prime( $n ) } @binary;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ binary_prefix( 1, 0, 1 ) ], [ F, T, T ],
    'Example 1: binary_prefix( 1, 0, 1 ) == ( false, true, true )';
is [ binary_prefix( 1, 1, 0 ) ], [ F, T, F ],
    'Example 2: binary_prefix( 1, 1, 0 ) == ( false, true, false )';
is [ binary_prefix( qw( 1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1 ) ) ],
    [ F, T, T, F, F, T, F, F, F, F, F, F, F, F, F, F, F, F, F, T ],
    "Example 3:\n"
    . "    binary_prefix( qw( 1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1 ) ) ==\n"
    . "        ( false, true, true, false, false, true, false, false,\n"
    . "          false, false, false, false, false, false, false, false,\n"
    . "          false, false, false, true )";

done_testing;
