#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 352 Task 2: Binary Prefix
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

sub binary_prefix( @nums ) {
    my $n = 0;
    return map( ( $n = $n << 1 | $_ ) % 5 == 0, @nums );
}

use Test2::V0 qw( -no_srand );

is [ binary_prefix( 0, 1, 1, 0, 0, 1, 0, 1, 1, 1 ) ],
        [ T, F, F, F, F, T, T, F, F, F ],
    'Example 1: binary_prefix( 0, 1, 1, 0, 0, 1, 0, 1, 1, 1 )'
        . '== ( T, F, F, F, F, T, T, F, F, F )';
is [ binary_prefix( 1, 0, 1, 0, 1, 0 ) ], [ F, F, T, T, F, F ],
    'Example 2: binary_prefix( 1, 0, 1, 0, 1, 0 ) == (F, F, T, T, F, F)';
is [ binary_prefix( 0, 0, 1, 0, 1 ) ], [ T, T, F, F, T ],
    'Example 3: binary_prefix( 0, 0, 1, 0, 1 ) == (T, T, F, F, T)';
is [ binary_prefix( 1, 1, 1, 1, 1 ) ], [ F, F, F, T, F ],
    'Example 4: binary_prefix( 1, 1, 1, 1, 1 ) == (F, F, F, T, F)';
is [ binary_prefix( 1, 0, 1, 1, 0, 1, 0, 0, 1, 1 ) ],
        [ F, F, T, F, F, T, T, T, F, F ],
    'Example 5: binary_prefix( 1, 0, 1, 1, 0, 1, 0, 0, 1, 1 )'
        . ' == ( F, F, T, F, F, T, T, T, F, F )';

done_testing;
