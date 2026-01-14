#!/usr/bin/env perl

# It’s NFL playoff time. Since the 2020 season, seven teams from each of
# the league’s two conferences (AFC and NFC) qualify for the playoffs based
# on regular season winning percentage, with a tie-breaking procedure if required.
# The top team in each conference receives a first-round bye, automatically
# advancing to the second round.

# The following games are played. Some times the games are played in a different
# order. To make things easier, assume the order is always as below.

# Week 1: Wild card playoffs

# - Team 1 gets a bye
#   - Game 1: Team 2 hosts Team 7
#   - Game 2: Team 3 hosts Team 6
#   - Game 3: Team 4 hosts Team 5
# - Week 2: Divisional playoffs
#   - Game 4: Team 1 hosts the third seeded winner from the previous week.
#   - Game 5: The highest seeded winner from the previous week hosts the second
#             seeded winner.
# - Week 3: Conference final
#   - Game 6: The highest seeded winner from the previous week hosts the
#              other winner

# You are given a six character string containing only H (home) and A away which
# has the winner of each game. Which two teams competed in the conference
# final and who won?

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub who_wins {
    my $results = shift;

    my @results = split '', $results;
    say q{Input: $results = "} . $results . q{"};

    my @schedule
        = ( { H => 2, A => 7 }, { H => 3, A => 6 }, { H => 4, A => 5 }, );
    my @winners
        = sort { $a <=> $b } map { $schedule[$_]->{ shift @results } } 0 .. 2;

    @schedule = (
                  { H => 1,              A => pop @winners },
                  { H => shift @winners, A => shift @winners }
                );
    @winners
        = sort { $a <=> $b } map { $schedule[$_]->{ shift @results } } 0 .. 1;

    @winners = reverse @winners if shift @results eq 'A';

    $results = sprintf "Team %d defeated Team %d", $winners[0], $winners[1];
    say q{Output: } . $results;
    return $results;
}

my @examples = (

                {  in   => "HAHAHH",
                   out  => "Team 2 defeated Team 6",
                   name => 'example 1'
                },

                {  in   => "HHHHHH",
                   out  => "Team 1 defeated Team 2",
                   name => 'example 2'
                },

                {  in   => "HHHAHA",
                   out  => "Team 4 defeated Team 2",
                   name => 'example 3'
                },

                {  in   => "HAHAAH",
                   out  => "Team 4 defeated Team 6",
                   name => 'example 4'
                },

                {  in   => "HAAHAA",
                   out  => "Team 5 defeated Team 1",
                   name => 'example 5'
                },
               );

is( who_wins( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

