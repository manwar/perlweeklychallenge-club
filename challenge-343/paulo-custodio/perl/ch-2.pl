#!/usr/bin/env perl

# Challenge 343
#
# Task 2: Champion Team
# Submitted by: Mohammad Sajid Anwar
# You have n teams in a tournament. A matrix grid tells you which team is stronger between any two teams:
#
# If grid[i][j] == 1, then team i is stronger than team j
# If grid[i][j] == 0, then team j is stronger than team i
# Find the champion team - the one with most wins, or if there is no single such team, the strongest of the teams with most wins. (You may assume that there is a definite answer.)
#
#
# Example 1
# Input: @grid = (
#                  [0, 1, 1],
#                  [0, 0, 1],
#                  [0, 0, 0],
#                )
# Output: Team 0
#
# [0, 1, 1] => Team 0 beats Team 1 and Team 2
# [0, 0, 1] => Team 1 beats Team 2
# [0, 0, 0] => Team 2 loses to all
#
# Example 2
# Input: @grid = (
#                  [0, 1, 0, 0],
#                  [0, 0, 0, 0],
#                  [1, 1, 0, 0],
#                  [1, 1, 1, 0],
#                )
# Output: Team 3
#
# [0, 1, 0, 0] => Team 0 beats only Team 1
# [0, 0, 0, 0] => Team 1 loses to all
# [1, 1, 0, 0] => Team 2 beats Team 0 and Team 1
# [1, 1, 1, 0] => Team 3 beats everyone
#
# Example 3
# Input: @grid = (
#                  [0, 1, 0, 1],
#                  [0, 0, 1, 1],
#                  [1, 0, 0, 0],
#                  [0, 0, 1, 0],
#                )
# Output: Team 0
#
# [0, 1, 0, 1] => Team 0 beats teams 1 and 3
# [0, 0, 1, 1] => Team 1 beats teams 2 and 3
# [1, 0, 0, 0] => Team 2 beats team 0
# [0, 0, 1, 0] => Team 3 beats team 2
#
# Of the teams with 2 wins, Team 0 beats team 1.
#
# Example 4
# Input: @grid = (
#                  [0, 1, 1],
#                  [0, 0, 0],
#                  [0, 1, 0],
#                )
# Output: Team 0
#
# [0, 1, 1] => Team 0 beats Team 1 and Team 2
# [0, 0, 0] => Team 1 loses to Team 2
# [0, 1, 0] => Team 2 beats Team 1 but loses to Team 0
#
# Example 5
# Input: @grid = (
#                  [0, 0, 0, 0, 0],
#                  [1, 0, 0, 0, 0],
#                  [1, 1, 0, 1, 1],
#                  [1, 1, 0, 0, 0],
#                  [1, 1, 0, 1, 0],
#                )
# Output: Team 2
#
# [0, 0, 0, 0, 0] => Team 0 loses to all
# [1, 0, 0, 0, 0] => Team 1 beats only Team 0
# [1, 1, 0, 1, 1] => Team 2 beats everyone except self
# [1, 1, 0, 0, 0] => Team 3 loses to Team 2
# [1, 1, 0, 1, 0] => Team 4 loses to Team 2

use Modern::Perl;

my @m = parse_input();
say "Team ", champion(@m);

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}

sub champion {
    my(@m) = @_;
    my @wins = sort {
        # Primary sort: Total wins
        $a->[1] <=> $b->[1]
        ||
        # Tie-breaker: Head-to-head result between team a and team b
        # $a->[0] and $b->[0] are the team indices
        $m[ $a->[0] ][ $b->[0] ] <=> $m[ $b->[0] ][ $a->[0] ]
    } map {[$_, sum(@{$m[$_]})]} 0..$#m;
    return $wins[-1][0];
}

sub sum {
    my $s = 0;
    $s += $_ for @_;
    return $s;
}
