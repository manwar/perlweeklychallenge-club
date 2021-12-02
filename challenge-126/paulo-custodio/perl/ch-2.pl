#!/usr/bin/env perl

# Challenge 126
#
# TASK #2 > Minesweeper Game
# Submitted by: Cheok-Yin Fung
# You are given a rectangle with points marked with either x or *. Please
# consider the x as a land mine.
#
# Write a script to print a rectangle with numbers and x as in the Minesweeper
# game.
#
# A number in a square of the minesweeper game indicates the number of mines
# within the neighbouring squares (usually 8), also implies that there are no
# bombs on that square.
#
# Example
# Input:
#     x * * * x * x x x x
#     * * * * * * * * * x
#     * * * * x * x * x *
#     * * * x x * * * * *
#     x * * * x * * * * x
#
# Output:
#     x 1 0 1 x 2 x x x x
#     1 1 0 2 2 4 3 5 5 x
#     0 0 1 3 x 3 x 2 x 2
#     1 1 1 x x 4 1 2 2 2
#     x 1 1 3 x 2 0 0 1 x

use Modern::Perl;

my @board = parse_board();
compute_mines(\@board);
show_board(@board);

sub parse_board {
    my @board;
    while(<>) {
        my @row = split(' ', $_);
        push @board, \@row;
    }
    return @board;
}

sub compute_mines {
    my($board) = @_;
    my $height = @$board;
    my $width  = @{$board->[0]};
    for my $r (0 .. $height-1) {
        for my $c (0 .. $width-1) {
            if (!has_mine($board, $r, $c)) {
                my $count = 0;
                $count++ if has_mine($board, $r-1, $c-1);
                $count++ if has_mine($board, $r-1, $c);
                $count++ if has_mine($board, $r-1, $c+1);
                $count++ if has_mine($board, $r, $c-1);
                $count++ if has_mine($board, $r, $c+1);
                $count++ if has_mine($board, $r+1, $c-1);
                $count++ if has_mine($board, $r+1, $c);
                $count++ if has_mine($board, $r+1, $c+1);
                $board->[$r][$c] = $count;
            }
        }
    }
}

sub has_mine {
    my($board, $r, $c) = @_;
    my $height = @$board;
    my $width  = @{$board->[0]};
    return 0 if $r<0 || $r>=$height;
    return 0 if $c<0 || $c>=$width;
    return 1 if $board->[$r][$c] eq 'x';
    return 0;
}

sub show_board {
    my(@board) = @_;
    for (@board) {
        say join ' ', @$_;
    }
}
