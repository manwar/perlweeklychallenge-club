#!/usr/bin/env perl

# Challenge 337
#
# Task 2: Odd Matrix
# Submitted by: Mohammad Sajid Anwar
# You are given row and col, also a list of positions in the matrix.
#
# Write a script to perform action on each location (0-indexed) as provided in the list and find out the total odd valued cells.
#
# For each location (r, c), do both of the following:
#
# a) Increment by 1 all the cells on row r.
# b) Increment by 1 all the cells on column c.
#
# Example 1
# Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
# Output: 6
#
# Initial:
# [ 0 0 0 ]
# [ 0 0 0 ]
#
# Apply [0,1]:
# Increment row 0:
# Before     After
# [ 0 0 0 ]  [ 1 1 1 ]
# [ 0 0 0 ]  [ 0 0 0 ]
# Increment col 1:
# Before     After
# [ 1 1 1 ]  [ 1 2 1 ]
# [ 0 0 0 ]  [ 0 1 0 ]
#
# Apply [1,1]:
# Increment row 1:
# Before     After
# [ 1 2 1 ]  [ 1 2 1 ]
# [ 0 1 0 ]  [ 1 2 1 ]
# Increment col 1:
# Before     After
# [ 1 2 1 ]  [ 1 3 1 ]
# [ 1 2 1 ]  [ 1 3 1 ]
#
# Final:
# [ 1 3 1 ]
# [ 1 3 1 ]
#
# Example 2
# Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
# Output: 0
#
# Initial:
# [ 0 0 ]
# [ 0 0 ]
#
# Apply [1,1]:
# Increment row 1:
# Before    After
# [ 0 0 ]   [ 0 0 ]
# [ 0 0 ]   [ 1 1 ]
# Increment col 1:
# Before    After
# [ 0 0 ]   [ 0 1 ]
# [ 1 1 ]   [ 1 2 ]
#
# Apply [0,0]:
# Increment row 0:
# Before    After
# [ 0 1 ]   [ 1 2 ]
# [ 1 2 ]   [ 1 2 ]
# Increment col 0:
# Before    After
# [ 1 2 ]   [ 2 2 ]
# [ 1 2 ]   [ 2 2 ]
#
# Final:
# [ 2 2 ]
# [ 2 2 ]
#
# Example 3
# Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
# Output: 0
#
# Initial:
# [ 0 0 0 ]
# [ 0 0 0 ]
# [ 0 0 0 ]
#
# Apply [0,0]:
# Increment row 0:
# Before     After
# [ 0 0 0 ]  [ 1 1 1 ]
# [ 0 0 0 ]  [ 0 0 0 ]
# [ 0 0 0 ]  [ 0 0 0 ]
# Increment col 0:
# Before     After
# [ 1 1 1 ]  [ 2 1 1 ]
# [ 0 0 0 ]  [ 1 0 0 ]
# [ 0 0 0 ]  [ 1 0 0 ]
#
# Apply [1,2]:
# Increment row 1:
# Before     After
# [ 2 1 1 ]  [ 2 1 1 ]
# [ 1 0 0 ]  [ 2 1 1 ]
# [ 1 0 0 ]  [ 1 0 0 ]
# Increment col 2:
# Before     After
# [ 2 1 1 ]  [ 2 1 2 ]
# [ 2 1 1 ]  [ 2 1 2 ]
# [ 1 0 0 ]  [ 1 0 1 ]
#
# Apply [2,1]:
# Increment row 2:
# Before     After
# [ 2 1 2 ]  [ 2 1 2 ]
# [ 2 1 2 ]  [ 2 1 2 ]
# [ 1 0 1 ]  [ 2 1 2 ]
# Increment col 1:
# Before     After
# [ 2 1 2 ]  [ 2 2 2 ]
# [ 2 1 2 ]  [ 2 2 2 ]
# [ 2 1 2 ]  [ 2 2 2 ]
#
# Final:
# [ 2 2 2 ]
# [ 2 2 2 ]
# [ 2 2 2 ]
#
# Example 4
# Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
# Output: 2
#
# Initial:
# [ 0 0 0 0 0 ]
#
# Apply [0,2]:
# Increment row 0:
# Before         After
# [ 0 0 0 0 0 ]  [ 1 1 1 1 1 ]
# Increment col 2:
# Before         After
# [ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]
#
# Apply [0,4]:
# Increment row 0:
# Before         After
# [ 1 1 2 1 1 ]  [ 2 2 3 2 2 ]
# Increment col 4:
# Before         After
# [ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]
#
# Final:
# [ 2 2 3 2 3 ]
#
# Example 5
# Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
# Output: 8
#
# Initial:
# [ 0 0 ]
# [ 0 0 ]
# [ 0 0 ]
# [ 0 0 ]
#
# Apply [1,0]:
# Increment row 1:
# Before     After
# [ 0 0 ]    [ 0 0 ]
# [ 0 0 ]    [ 1 1 ]
# [ 0 0 ]    [ 0 0 ]
# [ 0 0 ]    [ 0 0 ]
# Increment col 0:
# Before     After
# [ 0 0 ]    [ 1 0 ]
# [ 1 1 ]    [ 2 1 ]
# [ 0 0 ]    [ 1 0 ]
# [ 0 0 ]    [ 1 0 ]
#
# Apply [3,1]:
# Increment row 3:
# Before     After
# [ 1 0 ]    [ 1 0 ]
# [ 2 1 ]    [ 2 1 ]
# [ 1 0 ]    [ 1 0 ]
# [ 1 0 ]    [ 2 1 ]
# Increment col 1:
# Before     After
# [ 1 0 ]    [ 1 1 ]
# [ 2 1 ]    [ 2 2 ]
# [ 1 0 ]    [ 1 1 ]
# [ 2 1 ]    [ 2 2 ]
#
# Apply [2,0]:
# Increment row 2:
# Before     After
# [ 1 1 ]    [ 1 1 ]
# [ 2 2 ]    [ 2 2 ]
# [ 1 1 ]    [ 2 2 ]
# [ 2 2 ]    [ 2 2 ]
# Increment col 0:
# Before     After
# [ 1 1 ]    [ 2 1 ]
# [ 2 2 ]    [ 3 2 ]
# [ 2 2 ]    [ 3 2 ]
# [ 2 2 ]    [ 3 2 ]
#
# Apply [0,1]:
# Increment row 0:
# Before     After
# [ 2 1 ]    [ 3 2 ]
# [ 3 2 ]    [ 3 2 ]
# [ 3 2 ]    [ 3 2 ]
# [ 3 2 ]    [ 3 2 ]
# Increment col 1:
# Before     After
# [ 3 2 ]    [ 3 3 ]
# [ 3 2 ]    [ 3 3 ]
# [ 3 2 ]    [ 3 3 ]
# [ 3 2 ]    [ 3 3 ]
#
# Final:
# [ 3 3 ]
# [ 3 3 ]
# [ 3 3 ]
# [ 3 3 ]

use Modern::Perl;

# parse input
my($rows, $cols) = split ' ', <>;
my @ops;
while (<>) {
    push @ops, [split ' ', $_];
}

my @m = do_ops($rows, $cols, @ops);

for (@m) {
    say join ' ', @$_;
}

sub do_ops {
    my($rows, $cols, @ops) = @_;
    for (0 .. $rows-1) {
        push @m, [(0) x $cols];
    }
    for (@ops) {
        my($row, $col) = @$_;
        # increment row
        for my $c (0 .. $cols-1) {
            $m[$row][$c]++;
        }
        # increment col
        for my $r (0 .. $rows-1) {
            $m[$r][$col]++;
        }
    }
    return @m;
}
