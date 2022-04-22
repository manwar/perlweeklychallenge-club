#!/usr/bin/env perl

# Challenge 062
#
# TASK #2 › N Queens
# Submitted by: Ryan Thompson
#
# A standard 8×8 chessboard has 64 squares. The Queen is a chesspiece that can
# attack in 8 directions, as shown by the green shaded squares below:
#
#
#
# It is possible to place 8 queens on to a single chessboard such that none of
# the queens can attack each other (i.e., their shaded squares would not
# overlap). In fact, there are multiple ways to do so, and this is a favourite
# undergraduate assignment in computer science.
#
# But here at PWC, we’re going to take it into the next dimension!
#
# Your job is to write a script to work with a three dimensional chess cube,
# M×M×M in size, and find a solution that maximizes the number of queens that
# can be placed in that cube without attacking each other. Output one possible
# solution.
#
# Example
# A trivial 2×2×2 solution might look like this (1 = queen, 0 = empty):
#
# [
#     [[1,0],     # Layer 1
#      [0,0]],
#
#     [[0,0],     # Layer 2
#      [0,0]],
# ]

use Modern::Perl;
use Clone 'clone';
use constant M => 2;
use Data::Dump 'dump';

my @board;
for my $l (0..M-1) {
    $board[$l] = [];
    for my $r (0..M-1) {
        push @{$board[$l]}, [(0) x M];
    }
}

my $max_board = clone(\@board);
my $max_queens = 0;

place_queens(0, \@board);
say dump($max_board);

sub place_queens {
    my($queens, $board) = @_;

    # check for empty spaces
    my $full = 1;
    for my $l (0..M-1) {
        for my $r (0..M-1) {
            for my $c (0..M-1) {
                if ($board->[$l][$r][$c] eq 0) {
                    $full = 0;
                    # empty, place queen
                    my $copy = clone($board);
                    # fill atack positions
                    for my $i (0..M-1) {
                        set($copy, $i, $r, $c);
                        set($copy, $l, $i, $c);
                        set($copy, $l, $r, $i);

                        set($copy, $l, $r-$i, $c-$i);
                        set($copy, $l, $r-$i, $c+$i);
                        set($copy, $l, $r+$i, $c-$i);
                        set($copy, $l, $r+$i, $c+$i);

                        set($copy, $l-$i, $r, $c-$i);
                        set($copy, $l-$i, $r, $c+$i);
                        set($copy, $l+$i, $r, $c-$i);
                        set($copy, $l+$i, $r, $c+$i);

                        set($copy, $l-$i, $r-$i, $c);
                        set($copy, $l-$i, $r+$i, $c);
                        set($copy, $l+$i, $r-$i, $c);
                        set($copy, $l+$i, $r+$i, $c);

                        set($copy, $l-$i, $r-$i, $c-$i);
                        set($copy, $l-$i, $r-$i, $c+$i);
                        set($copy, $l-$i, $r+$i, $c-$i);
                        set($copy, $l-$i, $r+$i, $c+$i);

                        set($copy, $l+$i, $r-$i, $c-$i);
                        set($copy, $l+$i, $r-$i, $c+$i);
                        set($copy, $l+$i, $r+$i, $c-$i);
                        set($copy, $l+$i, $r+$i, $c+$i);
                    }
                    # fill queen position
                    $copy->[$l][$r][$c] = 'Q';
                    #die dump($copy);
                    # recurse
                    place_queens($queens+1, $copy);
                }
            }
        }
    }
    if ($full) {
        if ($queens > $max_queens) {
            $max_queens = $queens;
            $max_board = clone($board);
        }
    }
}

sub set {
    my($board, $l, $r, $c) = @_;
    if ($l>=0 && $l<M &&
        $r>=0 && $r<M &&
        $c>=0 && $c<M) {
        $board->[$l][$r][$c] = 1;
    }
}
