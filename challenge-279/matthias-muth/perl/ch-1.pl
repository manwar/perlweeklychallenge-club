#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 279 Task 1: Sort Letters
#
#       Perl solution by Matthias Muth.
#

use v5.36;
no warnings 'experimental::for_list';

use List::Util qw( mesh );

sub sort_letters_1( $letters, $weights ) {
    my @ordered_letters;
    for my ( $letter, $weight ) ( mesh $letters, $weights ) {
        # Ordered letters are 0-based, while weights are 1-based.
        $ordered_letters[ $weight - 1 ] = $letter;
    }
    return join "", @ordered_letters;
}

sub sort_letters_2( $letters, $weights ) {
    my $result = " " x $letters->@*;
    for my ( $letter, $weight ) ( mesh $letters, $weights ) {
        # Letter positions are 0-based, while weights are 1-based.
        substr $result, $weight - 1, 1, $letter;
    }
    return $result;
}

sub sort_letters_3( $letters, $weights ) {
    # Note that weights are 1-based, while letter positions are 0-based.
    my $result = " " x $letters->@*;
    substr $result, $weights->[$_] - 1, 1, $letters->[$_]
        for 0..$letters->$#*;
    return $result;
}

sub sort_letters( $letters, $weights ) {
    my %buckets;
    for my ( $letter, $weight ) ( mesh $letters, $weights ) {
        push $buckets{$weight}->@*, $letter;
    }
    return join "", map $buckets{$_}->@*, sort { $a <=> $b } keys %buckets;
}


use Test2::V0 qw( -no_srand );
is sort_letters( ["R", "E", "P", "L"], [3, 2, 1, 4] ), "PERL",
    'Example 1: sort_letters( ["R", "E", "P", "L"], [3, 2, 1, 4] ) == "PERL"';
is sort_letters( ["A", "U", "R", "K"], [2, 4, 1, 3] ), "RAKU",
    'Example 2: sort_letters( ["A", "U", "R", "K"], [2, 4, 1, 3] ) == "RAKU"';
is sort_letters( ["O", "H", "Y", "N", "P", "T"], [5, 4, 2, 6, 1, 3] ), "PYTHON",
    'Example 3: sort_letters( ["O", "H", "Y", "N", "P", "T"], [5, 4, 2, 6, 1, 3] ) == "PYTHON"';
is sort_letters( ["R", "E", "P", "L"], [33, 22, 11, 33] ), "PERL",
    'Test 1: sort_letters( ["R", "E", "P", "L"], [33, 22, 11, 33] ) == "PERL"';
done_testing;
