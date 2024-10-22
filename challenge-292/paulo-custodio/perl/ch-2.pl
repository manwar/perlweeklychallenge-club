#!/usr/bin/env perl

# Challenge 292
#
# Task 2: Zuma Game
# Submitted by: Mohammad Sajid Anwar
#
# You are given a single row of colored balls, $row and a random number of
# colored balls in $hand.
#
# Here is the variation of Zuma game as your goal is to clear all of the balls
# from the board. Pick any ball from your hand and insert it in between two
# balls in the row or on either end of the row. If there is a group of three
# or more consecutive balls of the same color then remove the group of balls
# from the board. If there are no more balls on the board then you win the game.
# Repeat this process until you either win or do not have any more balls in
# your hand.
#
# Write a script to minimum number of balls you have to insert to clear all
# the balls from the board. If you cannot clear all the balls from the board
# using the balls in your hand, return -1.
# Example 1
#
# Input: $board = "WRRBBW", $hand = "RB"
# Output: -1
#
# It is impossible to clear all the balls. The best you can do is:
# - Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
# - Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
# There are still balls remaining on the board, and you are out of balls to insert.
#
# Example 2
#
# Input: $board = "WWRRBBWW", $hand = "WRBRW"
# Output: 2
#
# To make the board empty:
# - Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
# - Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
# 2 balls from your hand were needed to clear the board.
#
# Example 3
#
# Input: $board = "G", $hand = "GGGGG"
# Output: 2
#
# To make the board empty:
# - Insert 'G' so the board becomes GG.
# - Insert 'G' so the board becomes GGG. GGG -> empty.
# 2 balls from your hand were needed to clear the board.

use Modern::Perl;

sub draw {
    my($board, $hand) = @_;

    my %not_yet;
    for my $ball (split //, $board) {
        if ($board =~ /$ball[^$ball]+$ball/) {
            $not_yet{$ball} = 1;
        }
    }

    while ($board =~ /(.)\1/g) {
        my $ball = $1;
        if (!$not_yet{$ball} && $hand =~ /$ball/) {
            $board =~ s/$ball{2,}//;
            $board =~ s/(.)\1\1+//g;
            $hand =~ s/$ball//;
            return (1, $board, $hand);
        }
    }

    for my $ball (split //, $board) {
        if ($hand =~ /$ball/) {
            $board =~ s/$ball/$ball$ball/;
            $board =~ s/(.)\1\1+//g;
            $hand =~ s/$ball//;
            return (1, $board, $hand);
        }
    }

    return (0, $board, $hand);
}

sub play {
    my($board, $hand) = @_;
    my $rounds = 0;
    for (;;) {
        return $rounds if $board eq '';
        return -1 if $hand eq '';
        (my $moved, $board, $hand) = draw($board, $hand);
        return -1 if !$moved;
        $rounds++;
    }
}

say play(@ARGV);
