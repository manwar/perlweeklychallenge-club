#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 326 Task 2: Decompressed List
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub decompressed_list_multi_value_for( @ints ) {
    my @decompressed;
    for my ( $n, $i ) ( @ints ) {
        push @decompressed, ( $i ) x $n;
    }
    return @decompressed;
}

use List::Util qw( pairs pairmap );

sub decompressed_list_pairmap( @ints ) {
    return pairmap { ( $b ) x $a } @ints;
}

sub decompressed_list_pairs( @ints ) {
    return map { ( $_->[1] ) x $_->[0] } pairs @ints;
}

sub decompressed_list_map_keys( @ints ) {
    return map {
        $_ & 1 ? () : ( $ints[ $_ + 1 ] ) x $ints[$_];
    } keys @ints;
}

sub decompressed_list_for_keys( @ints ) {
    my @decompressed;
    for ( keys @ints ) {
        push @decompressed, ( $ints[ $_ ] ) x $ints[ $_ - 1 ]
            if $_ & 0x01;
    }
    return @decompressed;
}

sub decompressed_list_c_style_for( @ints ) {
    my @decompressed;
    for ( my $i = 0; $i <= $#ints; $i += 2 ) {
        push @decompressed, ( $ints[ $i + 1 ] ) x $ints[ $i ];
    }
    return @decompressed;
}

*decompressed_list = \&decompressed_list_c_style_for;

use Test2::V0 qw( -no_srand );

is [ decompressed_list( 1, 3, 2, 4 ) ], [ 3, 4, 4 ],
    'Example 1: decompressed_list( 1, 3, 2, 4 ) == (3, 4, 4)';
is [ decompressed_list( 1, 1, 2, 2 ) ], [ 1, 2, 2 ],
    'Example 2: decompressed_list( 1, 1, 2, 2 ) == (1, 2, 2)';
is [ decompressed_list( 3, 1, 3, 2 ) ], [ 1, 1, 1, 2, 2, 2 ],
    'Example 3: decompressed_list( 3, 1, 3, 2 ) == (1, 1, 1, 2, 2, 2)';

done_testing;

use Benchmark qw( cmpthese );

cmpthese -3, {
    multi_value_for => sub { decompressed_list_multi_value_for( 3, 1, 3, 2 ); },
    pairmap => sub { decompressed_list_pairmap( 3, 1, 3, 2 ); },
    # pairs => sub { decompressed_list_pairs( 3, 1, 3, 2 ); },
    # map_keys => sub { decompressed_list_map_keys( 3, 1, 3, 2 ); },
    # for_keys => sub { decompressed_list_for_keys( 3, 1, 3, 2 ); },
    c_style_for => sub { decompressed_list_c_style_for( 3, 1, 3, 2 ); },
};
