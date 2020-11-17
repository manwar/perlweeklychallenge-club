#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Games::Sudoku::Lite;

# TASK #2 › Sudoku Puzzle
# Submitted by: Mohammad S Anwar
#
# You are given Sudoku puzzle (9x9).
#
# Write a script to complete the puzzle

my $board;
my $rows = 0;
my $tot = 0;

while (<>) {
    if (/^Grid/) {
        say;
        next;
    }

    # reformat the problem to the format G::S::L expects
    s/_/./g;
    s/[\[\] ]//g;
    $board .= $_;
    if (++$rows == 9) {
        my $puzzle = Games::Sudoku::Lite->new($board);
        $puzzle->solve;
        my $sol = $puzzle->solution;

        # add spaces between the digits to make it easier to read
        $sol =~ s/(\d)/$1 /g;
        say $sol;
    }
}
