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

my $call_count = 0;

# Full version, including debugging output and call counting.
my $verbose = 1;
sub vsay( @args ) { say @args if $verbose }
sub making_change_full( $amount, @coins ) {
    state $indent = "";

    $call_count = 0
        unless @coins;
    ++$call_count;

    @coins = qw( 50 25 10 5 1 )
        unless @coins;
    vsay $indent, "making_change( $amount, @coins )";
    $indent .= "  ";
    my $n = 0;
    for ( 0..$#coins ) {
        if ( $coins[$_] > $amount ) {
            vsay $indent, "$coins[$_] is too big";
        }
        elsif ( $coins[$_] == $amount ) {
            ++$n;
            vsay $indent, "$coins[$_] is the exact amount. Found a combination.";
        }
        else {
            # $coins[$_] < $amount
            vsay $indent, "adding coin of $coins[$_] to the sequence,",
                " trying to change the rest of ", $amount - $coins[$_];
            $n += making_change( $amount - $coins[$_], @coins[$_..$#coins] );
        }
    }

    vsay $indent, "making_change( $amount, @coins ) returning $n";
    substr $indent, -2, 2, "";
    return $n;
}

# 'Real' version (with call counting added).
sub making_change( $amount, @coins ) {

    $call_count = 0
        unless @coins;
    ++$call_count;

    @coins = qw( 50 25 10 5 1 )
        unless @coins;

    my $n = 0;
    for ( 0..$#coins ) {
        $n +=
            $coins[$_] > $amount    ? 0
            : $coins[$_] == $amount ? 1
            : making_change( $amount - $coins[$_], @coins[$_..$#coins] );
    }
    return $n;
}

# 'Compressed' version (shortest).
# Nice to avoid the loop, but maybe less readable.
use List::Util qw( sum );
sub making_change_short( $amount, @coins ) {
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

use Test2::V0 qw( -no_srand );
use Memoize;

for my $round ( 1..2 ) {

    if ( $round == 1 ) {
        note "without Memoize:";
    }
    elsif ( $round == 2 ) {
        note "using Memoize:";
        memoize( 'making_change' );
    }

    is making_change( 9 ), 2,
        'Example 1: making_change( 9 ) == 2';
    note "call_count $call_count";
    is making_change( 15 ), 6,
        'Example 2: making_change( 15 ) == 6';
    note "call_count $call_count";
    is making_change( 100 ), 292,
        'Example 3: making_change( 100 ) == 292';
    note "call_count $call_count";

    note "";
}
done_testing;
