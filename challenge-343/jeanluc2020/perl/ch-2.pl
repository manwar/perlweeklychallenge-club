#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/#TASK2
#
# Task 2: Champion Team
# =====================
#
# You have n teams in a tournament. A matrix grid tells you which team is stronger between any two teams:
#
# If grid[i][j] == 1, then team i is stronger than team j
# If grid[i][j] == 0, then team j is stronger than team i
#
# Find the champion team - the one with most wins, or if there is no single such team, the strongest of the teams with most wins. (You may assume that there is a definite answer.)
#
## Example 1
##
## Input: @grid = (
##                  [0, 1, 1],
##                  [0, 0, 1],
##                  [0, 0, 0],
##                )
## Output: Team 0
##
## [0, 1, 1] => Team 0 beats Team 1 and Team 2
## [0, 0, 1] => Team 1 beats Team 2
## [0, 0, 0] => Team 2 loses to all
#
#
## Example 2
##
## Input: @grid = (
##                  [0, 1, 0, 0],
##                  [0, 0, 0, 0],
##                  [1, 1, 0, 0],
##                  [1, 1, 1, 0],
##                )
## Output: Team 3
##
## [0, 1, 0, 0] => Team 0 beats only Team 1
## [0, 0, 0, 0] => Team 1 loses to all
## [1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
## [1, 1, 1, 0] => Team 3 beats everyone
#
#
## Example 3
##
## Input: @grid = (
##                  [0, 1, 0, 1],
##                  [0, 0, 1, 1],
##                  [1, 0, 0, 0],
##                  [0, 0, 1, 0],
##                )
## Output: Team 0
##
## [0, 1, 0, 1] => Team 0 beats teams 1 and 3
## [0, 0, 1, 1] => Team 1 beats teams 2 and 3
## [1, 0, 0, 0] => Team 2 beats team 0
## [0, 0, 1, 0] => Team 3 beats team 2
##
## Of the teams with 2 wins, Team 0 beats team 1.
#
#
## Example 4
##
## Input: @grid = (
##                  [0, 1, 1],
##                  [0, 0, 0],
##                  [0, 1, 0],
##                )
## Output: Team 0
##
## [0, 1, 1] => Team 0 beats Team 1 and Team 2
## [0, 0, 0] => Team 1 loses to Team 2
## [0, 1, 0] => Team 2 beats Team 1 but loses to Team 0
#
#
## Example 5
##
## Input: @grid = (
##                  [0, 0, 0, 0, 0],
##                  [1, 0, 0, 0, 0],
##                  [1, 1, 0, 1, 1],
##                  [1, 1, 0, 0, 0],
##                  [1, 1, 0, 1, 0],
##                )
## Output: Team 2
##
## [0, 0, 0, 0, 0] => Team 0 loses to all
## [1, 0, 0, 0, 0] => Team 1 beats only Team 0
## [1, 1, 0, 1, 1] => Team 2 beats everyone except self
## [1, 1, 0, 0, 0] => Team 3 loses to Team 2
## [1, 1, 0, 1, 0] => Team 4 loses to Team 2
#
############################################################
##
## discussion
##
############################################################
#
# First, we count the wins per team and find the maximum.
# Then, we find all teams that match the maximum. If that
# is only one team, we can return it. Otherwise, we pick all
# the teams that match the maximum and only compare them by
# calling the function recursively. We also keep a mapping
# of the temporary array indices to the big @grid indices so
# we can map back to the correct entry.
#

use v5.36;

champion_team([0, 1, 1], [0, 0, 1], [0, 0, 0]);
champion_team([0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]);
champion_team([0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]);
champion_team([0, 1, 1], [0, 0, 0], [0, 1, 0]);
champion_team([0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1],
    [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]);


sub champion_team(@grid) {
    say "Input: (";
    foreach my $tmp (@grid) {
        say "        [" . join(", ", @$tmp) . "],";
    }
    say ")";
    my $result = _champion_team(@grid);
    say "Output: $result";
}

sub _champion_team(@grid) {
    my @wins_by_team = ();
    my $max = 0;
    foreach my $team_results (@grid) {
        my $wins = 0;
        foreach my $game (@$team_results) {
            $wins++ if $game;
        }
        push @wins_by_team, $wins;
        $max = $wins if $wins > $max;
    }
    my @max_winning_teams = ();
    foreach my $i (0..$#wins_by_team) {
        push @max_winning_teams, $i if $wins_by_team[$i] == $max;
    }
    if(scalar(@max_winning_teams) == 1) {
        return $max_winning_teams[0];
    }
    my $map = {};
    my @minigrid = ();
    foreach my $i (0..$#max_winning_teams) {
        my @tmp = ();
        $map->{$i} = $max_winning_teams[$i];
        foreach my $j (0..$#max_winning_teams) {
            push @tmp, $grid[$max_winning_teams[$i]][$max_winning_teams[$j]];
        }
        push @minigrid, [ @tmp ];
    }
    if(scalar(@grid) == scalar(@minigrid)) {
        die "Can't reduce number of teams for finding best of the best";
    }
    return _champion_team(@minigrid);
}
