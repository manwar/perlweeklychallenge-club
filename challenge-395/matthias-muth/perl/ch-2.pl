#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 395 Task 2: Word Squares
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub fill_square( $rows, $level, $candidates ) {
    # Find the candidates that match in the next row.
    # For each one that does, add it to the square
    # and do a recursive call to fill the subsequent rows.
    # Return when we get back a fully filled square.
    for my $candidate ( $candidates->@* ) {
        # Only use this candidate if it fits with what already is
        # in the square. At level 0, every word fits, so this can
        # be shortcut.
        next unless $level == 0 || $candidate =~ /^$rows->[$level]/;

        # Use a copy of the original rows for the recursive calls,
        # so that own copy remains unchanged.
        # Put the candidate into the appropriate row.
        my @rows = $rows->@*;
        $rows[$level] = $candidate;

        # Check the end condition.
        return @rows
            if $level == length( $rows[0] ) - 1;

        # Also add the candidate's letters in the appropriate column
        # in the rest of the rows.
        $rows[$_] .= substr( $candidate, $_, 1 )
            for $level + 1 .. length( $candidate ) - 1;

        # Do the recursive call.
        my @result =
            fill_square( \@rows, $level + 1,
                [ grep { $_ ne $candidate } $candidates->@* ] );
        return @result if @result;
        # If no result, try the next candidate.
    }
    return;
}

sub word_squares( @words ) {
    return fill_square( [], 0, [ @words ] );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["MA", "AM", "MY", "ME"], ["MA", "AM"] ],
    [ "Example 2", ["SUN", "USE", "NET", "SEE", "TEN"], ["SUN", "USE", "NET"] ],
    [ "Example 3",
        ["BOAT", "TEAL", "AREA", "TSAR", "OGRE"],
        ["BOAT", "OGRE", "AREA", "TEAL"] ],
    [ "Example 4",
        ["CARD", "AREA", "REAR", "DART"],
        ["CARD", "AREA", "REAR", "DART"] ],
    [ "Example 5",
        ["HEART", "TREND", "EMBER", "RESIN", "ABUSE"],
        ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"] ],
    [ "Own Test 1", ["BOAT", "XXXX", "AREA", "OGRE"], [] ],
);

is [ word_squares( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
