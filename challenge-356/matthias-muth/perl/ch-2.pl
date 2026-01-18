#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 356 Task 2: Who Wins
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub who_wins( $results ) {
    my @results = ( undef, map /^H/ ? 0 : 1, split "", $results );
    my @games   = ( undef, [ 2, 7 ], [ 3, 6 ], [ 4, 5 ], [ 1 ] );
    say "results: @results[1..$#results]";
    say "games initially:   ", map " $_:[$games[$_]->@*]", 1..$#games;

    # Week 1:
    ( $games[5]->@[0,1], $games[4][1] ) =
        sort { $a <=> $b } map $games[$_][$results[$_]], 1..3;
    say "games after week 1:", map " $_:[$games[$_]->@*]", 1..$#games;

    # Week 2:
    $games[6]->@[0,1] =
        sort { $a <=> $b } map $games[$_][$results[$_]], 4, 5;
    say "games after week 2:", map " $_:[$games[$_]->@*]", 1..$#games;
    say "winner: $games[6][$results[6]]";

    return sprintf "Team %d defeated Team %d",
        $results[6] == 0 ? $games[6]->@* : reverse $games[6]->@*;
}

use Test2::V0 qw( -no_srand );

is who_wins( "HAHAHH" ), "Team 2 defeated Team 6",
    'Example 1: who_wins( "HAHAHH" ) => "Team 2 defeated Team 6"';
is who_wins( "HHHHHH" ), "Team 1 defeated Team 2",
    'Example 2: who_wins( "HHHHHH" ) => "Team 1 defeated Team 2"';
is who_wins( "HHHAHA" ), "Team 4 defeated Team 2",
    'Example 3: who_wins( "HHHAHA" ) => "Team 4 defeated Team 2"';
is who_wins( "HAHAAH" ), "Team 4 defeated Team 6",
    'Example 4: who_wins( "HAHAAH" ) => "Team 4 defeated Team 6"';
is who_wins( "HAAHAA" ), "Team 5 defeated Team 1",
    'Example 5: who_wins( "HAAHAA" ) => "Team 5 defeated Team 1"';

done_testing;
