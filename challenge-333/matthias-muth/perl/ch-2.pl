#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 333 Task 2: Duplicate Zeros
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub duplicate_zeros_loop( @ints ) {
    my @results = ();
    for ( @ints ) {
        for ( $_ || ( 0, 0 ) ) {
            push @results, $_;
            return @results
                if scalar @results == scalar @ints;
        }
    }
}

sub duplicate_zeros( @ints ) {
    return ( map $_ || ( 0, 0 ), @ints )[0..$#ints];
}

use Test2::V0 qw( -no_srand );

is [ duplicate_zeros( 1, 0, 2, 3, 0, 4, 5, 0 ) ], [ 1, 0, 0, 2, 3, 0, 0, 4 ],
    'Example 1: duplicate_zeros( 1, 0, 2, 3, 0, 4, 5, 0 ) == (1, 0, 0, 2, 3, 0, 0, 4)';
is [ duplicate_zeros( 1, 2, 3 ) ], [ 1, 2, 3 ],
    'Example 2: duplicate_zeros( 1, 2, 3 ) == (1, 2, 3)';
is [ duplicate_zeros( 1, 2, 3, 0 ) ], [ 1, 2, 3, 0 ],
    'Example 3: duplicate_zeros( 1, 2, 3, 0 ) == (1, 2, 3, 0)';
is [ duplicate_zeros( 0, 0, 1, 2 ) ], [ 0, 0, 0, 0 ],
    'Example 4: duplicate_zeros( 0, 0, 1, 2 ) == (0, 0, 0, 0)';
is [ duplicate_zeros( 1, 2, 0, 3, 4 ) ], [ 1, 2, 0, 0, 3 ],
    'Example 5: duplicate_zeros( 1, 2, 0, 3, 4 ) == (1, 2, 0, 0, 3)';
done_testing;

use Benchmark qw( cmpthese );

my @ints = ( 0 ) x 10000;
cmpthese( -3, {
    duplicate_zeros_loop => sub { duplicate_zeros_loop( @ints ) },
    duplicate_zeros      => sub { duplicate_zeros( @ints ) },
} );
