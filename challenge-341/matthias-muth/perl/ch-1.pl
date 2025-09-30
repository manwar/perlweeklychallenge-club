#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 341 Task 1: Broken Keyboard
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub broken_keyboard_short_and_ugly( $str, $keys ) {
    scalar grep ! $keys->@* || ! /[$keys->@*]/i, split " ", $str;
}

sub broken_keyboard( $str, $keys ) {
    my @words = split " ", $str;
    return scalar @words
        if ! $keys->@*;
    my $keys_concat = join "", $keys->@*;
    return scalar grep ! /[$keys_concat]/i, @words;
}

use Test2::V0 qw( -no_srand );

is broken_keyboard( "Hello World", ["d"] ), 1,
    'Example 1: broken_keyboard( "Hello World", ["d"] ) == 1';
is broken_keyboard( "apple banana cherry", ["a", "e"] ), 0,
    'Example 2: broken_keyboard( "apple banana cherry", ["a", "e"] ) == 0';
is broken_keyboard( "Coding is fun", [] ), 3,
    'Example 3: broken_keyboard( "Coding is fun", [] ) == 3';
is broken_keyboard( "The Weekly Challenge", ["a", "b"] ), 2,
    'Example 4: broken_keyboard( "The Weekly Challenge", ["a", "b"] ) == 2';
is broken_keyboard( "Perl and Python", ["p"] ), 1,
    'Example 5: broken_keyboard( "Perl and Python", ["p"] ) == 1';

done_testing;
