#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 331 Task 2: Buddy Strings
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

use List::Util qw( zip );

sub buddy_strings( $source, $target ) {
    # Check for equal lengths.
    return false
        unless length( $source ) == length( $target );

    # Extract pairs of differing characters.
    my @pairs = zip [ split "", $source ], [ split "", $target ];
    my @diff_pairs = grep $_->[0] ne $_->[1], @pairs;

    # Detect 'Standard' Buddies.
    return true
        if @diff_pairs == 2
            && $diff_pairs[0][0] eq $diff_pairs[1][1]
            && $diff_pairs[0][1] eq $diff_pairs[1][0];

    # Detect 'Equal' Buddies containing at least one repeated character.
    return false
        unless @diff_pairs == 0;
    my %seen;
    for ( split "", $source ) {
        return true
            if $seen{$_}++;
    }
    return false;
}

use Test2::V0 qw( -no_srand );

is buddy_strings( "fuck", "fcuk" ), T,
    'Example 1: buddy_strings( "fuck", "fcuk" ) is true';
is buddy_strings( "love", "love" ), F,
    'Example 2: buddy_strings( "love", "love" ) is false';
is buddy_strings( "fodo", "food" ), T,
    'Example 3: buddy_strings( "fodo", "food" ) is true';
is buddy_strings( "feed", "feed" ), T,
    'Example 4: buddy_strings( "feed", "feed" ) is true';
is buddy_strings( "", "" ), F,
    'Test 1: buddy_strings( "", "" ) is false';

done_testing;
