#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 399 Task 1: Longest Repeating Character
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( uniq max );

sub longest_repeating_character( $str, $k ) {
    # Shortcut if the input string contains only one distinct letter,
    # because then, there are no replacements to be made at all.
    return length( $str )
        if $str =~ /^(.)\g1*$/;

    my $longest = 0;
    # Check separately for each letter that exists in the string
    # whether it can produce the longest substring.
    for my $letter ( uniq split "", $str ) {
        # Loop over all string positions.
        # Starting at each string position that contains a character
        # *other* than $letter, turn (at most) $k characters other than
        # $letter into $letter (using a copy of the original string, and
        # skipping existing $letter characters).
        for my $start_pos ( 0.. length( $str ) - 1 ) {
            next unless substr( $str, $start_pos, 1 ) ne $letter;
            my ( $copy, $count ) = ( $str, 0 );
            for my $pos ( $start_pos .. length( $copy ) - 1 ) {
                if ( substr( $copy, $pos, 1 ) ne $letter ) {
                    # Found a non-$letter character. Replace it.
                    substr $copy, $pos, 1, $letter;
                    last if ++$count == $k;
                }
            }
            # As this substitution may extend or even combine existing
            # sequences of $letter, check the lengths of all such sequences
            # existing now to find the maximum length.
            $longest = max( $longest, map { length } $copy =~ /$letter+/g );
        }
    }
    return $longest;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Own Test 1", [ "AABBCCAAAABBCCDDD", 3 ], 7 ],
    [ "Own Test 2", [ "AABBCCAAAABBCCDDD", 4 ], 10 ],
    [ "Own Test 3", [ "AAAAB", 3 ], 5 ],
    [ "Example 1", ["AAAAA", 2], 5 ],
    [ "Example 2", ["ABCDE", 4], 5 ],
    [ "Example 3", ["AAABBBBAA", 1], 5 ],
    [ "Example 4", ["ABACADA", 2], 5 ],
    [ "Example 5", ["BAAABAAAA", 1], 8 ],
);


is longest_repeating_character( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
