#!/usr/bin/env perl

# Perl Weekly Challenge: Task 2 - Champion Team
# Find the team with the most wins, or the strongest among those with the most wins.

use strict;
use warnings;
use v5.30;

# Type definitions (using experimental Perl features for clarity)
use experimental 'signatures';

# Function to find the champion team
sub champion_team : prototype(@) (@grid) {
    my $n = @grid;
    return -1 unless $n;    # Return -1 for empty grid

    # Count wins for each team
    my @wins = (0) x $n;
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $n - 1 ) {
            $wins[$i] += $grid[$i][$j] if $i != $j;
        }
    }

    # Find maximum wins
    my $max_wins = 0;
    for my $win (@wins) {
        $max_wins = $win if $win > $max_wins;
    }

    # Find teams with maximum wins
    my @top_teams;
    for my $i ( 0 .. $n - 1 ) {
        push @top_teams, $i if $wins[$i] == $max_wins;
    }

    # If only one team has max wins, return it
    return "Team $top_teams[0]" if @top_teams == 1;

    # Among top teams, find the one that beats others
    for my $i (@top_teams) {
        my $is_champion = 1;
        for my $j (@top_teams) {
            next if $i == $j;
            unless ( $grid[$i][$j] ) {
                $is_champion = 0;
                last;
            }
        }
        return "Team $i" if $is_champion;
    }

    # Fallback (should not occur given problem constraints)
    return "Team $top_teams[0]";
}

# Unit tests
use Test::More;

# Test cases from the problem
is( champion_team( [ 0, 1, 1 ], [ 0, 0, 1 ], [ 0, 0, 0 ] ), 'Team 0', 'Test Case 1: 3x3 grid -> Team 0' );
is( champion_team( [ 0, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 1, 1, 0 ] ),
    'Team 3', 'Test Case 2: 4x4 grid -> Team 3' );
is( champion_team( [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ], [ 1, 0, 0, 0 ], [ 0, 0, 1, 0 ] ),
    'Team 0', 'Test Case 3: 4x4 grid -> Team 0' );
is( champion_team( [ 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 1, 0 ] ), 'Team 0', 'Test Case 4: 3x3 grid -> Team 0' );
is(
    champion_team(
        [ 0, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 1, 0, 1, 1 ],
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 0, 1, 0 ]
    ),
    'Team 2',
    'Test Case 5: 5x5 grid -> Team 2'
);

done_testing();
