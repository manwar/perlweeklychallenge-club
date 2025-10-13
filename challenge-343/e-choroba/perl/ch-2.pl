#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub champion_team(@grid) {
    my $max = 0;
    my %wins;
    for my $y (0 .. $#grid) {
        for my $x (0 .. $#{ $grid[$y] }) {
            my $w = $grid[$y][$x] ? $y : $x;
            $max = $w if ++$wins{$w} > $wins{$max};
        }
    }
    return "Team $max"
}

use Test::More tests => 5;

is champion_team(
                 [0, 1, 1],
                 [0, 0, 1],
                 [0, 0, 0],
               ), 'Team 0', 'Example 1';

is champion_team(
                 [0, 1, 0, 0],
                 [0, 0, 0, 0],
                 [1, 1, 0, 0],
                 [1, 1, 1, 0],
               ), 'Team 3', 'Example 2';

is champion_team(
                 [0, 1, 0, 1],
                 [0, 0, 1, 1],
                 [1, 0, 0, 0],
                 [0, 0, 1, 0],
               ), 'Team 0', 'Example 3';

is champion_team(
                 [0, 1, 1],
                 [0, 0, 0],
                 [0, 1, 0],
               ), 'Team 0', 'Example 4';

is champion_team(
                 [0, 0, 0, 0, 0],
                 [1, 0, 0, 0, 0],
                 [1, 1, 0, 1, 1],
                 [1, 1, 0, 0, 0],
                 [1, 1, 0, 1, 0],
               ), 'Team 2', 'Example 5';
