#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 388 Task 2: Secret Santa
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';
use Dsay;

use List::Util qw( product );

sub secret_santa( $n ) {
    return int( ( product( 1..$n ) + 1 ) / exp( 1 ) );
}

sub secret_santa_bfs( $n ) {
    my @results = ();
    my $assignment = [];
    my $gifts_available = [ undef, map true, 1..$n ];
    my @q = ( [ $assignment, $gifts_available ] );
    while ( @q ) {
        ( $assignment, $gifts_available ) = ( shift @q )->@*;
        # %debug and dsay pp( $assignment, $gifts_available );
        if ( $assignment->@* == $n ) {
            # %debug and dsay "  pushing to results";
            push @results, $assignment;
            next;
        }
        my $participant = scalar $assignment->@* + 1;
        for ( 1..$n ) {
            # %debug and dsay "  trying gift $_: ",
            # $gifts_available->[$_] ? "" : "not ", "available",
            # $_ == $participant ? ", gift to self" : "";
            next unless $gifts_available->[$_] && $_ != $participant;
            push @q, [
                [ $assignment->@*, $_ ],
                [ $gifts_available->@[ 0 .. ( $_ - 1 ) ],
                    false,
                    $gifts_available->@[ ( $_ + 1 ) .. $n ] ],
            ];
            # %debug and dsay "    pushing to q: ", pp $q[-1];
        }
    }
    # %debug and dsay pp @results;

    return scalar @results;
}

use lib qw( . ../../../lib );
use MultiTest;

my @tests = (
    [ "Example 1", 1, 0 ],
    [ "Example 2", 2, 1 ],
    [ "Example 3", 3, 2 ],
    [ "Example 4", 4, 9 ],
    [ "Example 5", 5, 44 ],
    [ "Test 6", 6, 265 ],
    [ "Test 7", 7, 1854 ],
    [ "Test 8", 8, 14833 ],
    [ "Test 9", 9, 133496 ],
    [ "Test 10", 10, 1334961 ],
);

run( "secret_santa", \@tests );
