#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 285 Task 2: Making Change
#
#       Perl solution by Matthias Muth.
#

use v5.36;
no warnings 'recursion';

sub making_change( $amount, @coins ) {
    state $indent = "";
    @coins = qw( 50 25 10 5 1 )
        unless @coins;
    say $indent, "making_change( $amount, @coins )";
    $indent .= "  ";
    my $n = 0;
    for ( 0..$#coins ) {
        if ( $coins[$_] > $amount ) {
            say $indent, "$coins[$_] is too big";
            next;
        }
        elsif ( $coins[$_] == $amount ) {
            ++$n;
            say $indent, "$coins[$_] is the exact amount. Found a combination.";
            next;
        }
        else {
            # $coins[$_] < $amount
            say $indent, "adding coin of $coins[$_] to the sequence,",
                " trying to change the rest of ", $amount - $coins[$_];
            $n += making_change( $amount - $coins[$_], @coins[$_..$#coins] );
        }
    }

    say $indent, "returning n==$n";
    substr $indent, -2, 2, "";
    return $n;
}

sub making_change( $amount, @coins ) {
    @coins = qw( 50 25 10 5 1 )
        unless @coins;
    my $n = 0;
    for ( 0..$#coins ) {
        $n +=
            $coins[$_] > $amount  ? 0
            : $coins[$_] == $amount ? 1
            : making_change( $amount - $coins[$_], @coins[$_..$#coins] );
    }
    return $n;
}

use List::Util qw( sum );

sub making_change_3( $amount, @coins ) {
    @coins = qw( 50 25 10 5 1 )
        unless @coins;
    return sum(
        map
            $coins[$_] > $amount  ? 0 :
            $coins[$_] == $amount ? 1 :
                making_change( $amount - $coins[$_], @coins[$_..$#coins] ),
        0..$#coins
    );
}

say making_change( 9 );

use Test2::V0 qw( -no_srand );
is making_change( 9 ), 2,
    'Example 1: making_change( 9 ) == 2';
is making_change( 15 ), 6,
    'Example 2: making_change( 15 ) == 6';
is making_change( 100 ), 292,
    'Example 3: making_change( 100 ) == 292';
done_testing;
