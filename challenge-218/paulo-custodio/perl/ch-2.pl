#!/usr/bin/perl

# Challenge 218
#
# Task 2: Matrix Score
# Submitted by: Mohammad S Anwar
#
# You are given a m x n binary matrix i.e. having only 1 and 0.
#
# You are allowed to make as many moves as you want to get the highest score.
#
#     A move can be either toggling each value in a row or column.
#
# To get the score, convert the each row binary to dec and return the sum.
# Example 1:
#
# Input: @matrix = [ [0,0,1,1],
#                    [1,0,1,0],
#                    [1,1,0,0], ]
# Output: 39
#
# Move #1: convert row #1 => 1100
#          [ [1,1,0,0],
#            [1,0,1,0],
#            [1,1,0,0], ]
#
# Move #2: convert col #3 => 101
#          [ [1,1,1,0],
#            [1,0,0,0],
#            [1,1,1,0], ]
#
# Move #3: convert col #4 => 111
#          [ [1,1,1,1],
#            [1,0,0,1],
#            [1,1,1,1], ]
#
# Score: 0b1111 + 0b1001 + 0b1111 => 15 + 9 + 15 => 39
#
# Example 2:
#
# Input: @matrix = [ [0] ]
# Output: 1

use Modern::Perl;
use List::Util 'sum';

sub compute_score {
    my(@game) = @_;
    return sum(map {oct("0b$_")} @game);
}

sub invert_row {
    my($row, @game) = @_;
    $game[$row] =~ tr/01/10/;
    return @game;
}

sub invert_col {
    my($col, @game) = @_;
    for (@game) {
        $_ = substr($_,0,$col).(1-substr($_,$col,1)).substr($_,$col+1);
    }
    return @game;
}

sub maximize_score {
    my(@game) = @_;
    my $max = compute_score(@game);
    my $changed;
    do {
        $changed = 0;
        for my $row (0..$#game) {
            my @new_game = invert_row($row, @game);
            my $new_max = compute_score(@new_game);
            if ($new_max > $max) {
                @game = @new_game;
                $max = $new_max;
                $changed = 1;
            }
        }
        for my $col (0..length($game[0])-1) {
            my @new_game = invert_col($col, @game);
            my $new_max = compute_score(@new_game);
            if ($new_max > $max) {
                @game = @new_game;
                $max = $new_max;
                $changed = 1;
            }
        }
    } while ($changed);
    return @game;
}

say compute_score(maximize_score(@ARGV));
