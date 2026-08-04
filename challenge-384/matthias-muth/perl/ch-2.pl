#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 384 Task 2: Special Binary Substrings
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( uniq );

sub special_binary_substrings_pos( $binary ) {
    my ( @results, %marked );
    for ( 0 .. length( $binary ) - 2 ) {
        pos( $binary ) = $_;
        if ( $binary =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx
            && ! $marked{$&} )
        {
            push @results, $&;
            $marked{$&} = 1;
        }
    }
    return @results;
}

sub special_binary_substrings_substr( $binary ) {
    my ( @results, %marked );
    for ( 0 .. length( $binary ) - 2 ) {
        if ( substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx
            && ! $marked{$&} )
        {
            push @results, $&;
            $marked{$&} = 1;
        }
    }
    return @results;
}

use List::Util qw( uniq );

sub special_binary_substrings_substr_uniq( $binary ) {
    my @results;
    for ( 0 .. length( $binary ) - 2 ) {
        push @results, $&
            if substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx;
    }
    return uniq @results;
}

sub special_binary_substrings( $binary ) {
    return uniq map {
        substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx
        ? $&
        : ()
    } 0 .. length( $binary ) - 2;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "0101", ["01", "10"] ],
    [ "Example 2", "000111", ["000111", "0011", "01"] ],
    [ "Example 3", "000011", ["0011", "01"] ],
    [ "Example 4", "10011100", ["10", "0011", "01", "1100"] ],
    [ "Example 5", "00000", [] ],
);

is [ special_binary_substrings( $_->[1] ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
