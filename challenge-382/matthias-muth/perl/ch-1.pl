#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 382 Task 1: Hamiltonian Cycle
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

my @is_square;

sub descend_hamiltonian( $chain, $available ) {
    my @solutions;
    if ( $available->@* == 0 ) {
        return $is_square[ $chain->[-1] + $chain->[0] ] ? $chain : ();
    }
    for ( keys $available->@* ) {
        if ( $is_square[ $chain->[-1] + $available->[$_] ] ) {
            push @solutions,
                descend_hamiltonian(
                    [ $chain->@*, $available->[$_] ],
                    [ $available->@[ 0 .. $_ - 1, $_ + 1 .. $available->$#* ] ]
                );
            # If we want to stop searching after we found
            # the first solution, we return from here:
            # return @solutions
            #     if @solutions;
        }
    }
    return @solutions;
}

sub hamiltonian_cycle( $n ) {
    # Create a lookup table for all perfect squares up to the largest
    # possible sum of two numbers i, j <= n.
    # It is much faster to look up whether ( i + j ) is a square number than
    # repeatedly computing the square root of ( i + j ) and checking
    # whether it is an integer.

    # It is much faster to look up whether ( i + j ) is a square number than
    # actually computing the square root and checking whether it is an
    # integer number.
    for ( my $i = 1; ( my $square = $i * $i ) <= ( $n - 1 ) + $n; ++$i ) {
        $is_square[ $square ] = 1;
    }

    # Start recursion with the first element as the chain, and all other
    # numbers available for completing the chain.
    # Use an array for the solutions, as there can be many of them.
    my ( $chain, $available ) = ( [ 1 ], [ 2..$n ] );
    my @solutions = descend_hamiltonian( $chain, $available );

    # Even if there can be multiple solutions, only return the first one. 
    return @solutions ? $solutions[0]->@* : ();
}

use Test2::V0 qw( -no_srand );

sub chain_check {
    my $chain = $_;     # Per Test2::V0 convention, validator callbacks
                        # receive the value to be checked in $_.
    return false unless $chain->@*;
    # Cheating for index 0 to compare with $chain->[-1], which miraculously
    # is the end of the chain.
    for ( keys $chain->@* ) {
        return false unless $is_square[ $chain->[$_] + $chain->[ $_ - 1 ] ];
    }
    return true;
}

my @tests = (
    [ "Example 1", 32, validator( \&chain_check ) ],
    [ "Example 2", 15, [] ],
    [ "Example 3", 34, validator( \&chain_check ) ],
);

is [ hamiltonian_cycle( $_->[1] ) ], $_->[2], $_->[0]
    for @tests;
done_testing;
