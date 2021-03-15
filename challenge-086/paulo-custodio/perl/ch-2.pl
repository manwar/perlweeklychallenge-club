#!/usr/bin/perl

# Challenge 086

# TASK #2 › Sudoku Puzzle
# Submitted by: Mohammad S Anwar
# You are given Sudoku puzzle (9x9).
#
# Write a script to complete the puzzle and must respect the following rules:
#
# a) Each row must have the numbers 1-9 occurring just once.
# b) Each column must have the numbers 1-9 occurring just once.
# c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
# Example:
# [ _ _ _ 2 6 _ 7 _ 1 ]
# [ 6 8 _ _ 7 _ _ 9 _ ]
# [ 1 9 _ _ _ 4 5 _ _ ]
# [ 8 2 _ 1 _ _ _ 4 _ ]
# [ _ _ 4 6 _ 2 9 _ _ ]
# [ _ 5 _ _ _ 3 _ 2 8 ]
# [ _ _ 9 3 _ _ _ 7 4 ]
# [ _ 4 _ _ 5 _ _ 3 6 ]
# [ 7 _ 3 _ 1 8 _ _ _ ]
# Output:
# [ 4 3 5 2 6 9 7 8 1 ]
# [ 6 8 2 5 7 1 4 9 3 ]
# [ 1 9 7 8 3 4 5 6 2 ]
# [ 8 2 6 1 9 5 3 4 7 ]
# [ 3 7 4 6 8 2 9 1 5 ]
# [ 9 5 1 7 4 3 6 2 8 ]
# [ 5 1 9 3 2 6 8 7 4 ]
# [ 2 4 8 9 5 7 1 3 6 ]
# [ 7 6 3 4 1 8 2 5 9 ]
# As the above puzzle respect the 3 rules including 9-sub-boxes as shown below:
#
# [ 4 3 5 ] [ 2 6 9 ] [ 7 8 1 ]
# [ 6 8 2 ] [ 5 7 1 ] [ 4 9 3 ]
# [ 1 9 7 ] [ 8 3 4 ] [ 5 6 2 ]
#
# [ 8 2 6 ] [ 1 9 5 ] [ 3 4 7 ]
# [ 3 7 4 ] [ 6 8 2 ] [ 9 1 5 ]
# [ 9 5 1 ] [ 7 4 3 ] [ 6 2 8 ]
#
# [ 5 1 9 ] [ 3 2 6 ] [ 8 7 4 ]
# [ 2 4 8 ] [ 9 5 7 ] [ 1 3 6 ]
# [ 7 6 3 ] [ 4 1 8 ] [ 2 5 9 ]

use strict;
use warnings;
use 5.030;
use Clone 'clone';

# read input, replace blanks by zero
my @m;
while (<>) {
    s/_/0/g; s/\D/ /g;
    my @row = split(' ', $_);
    @row == 9 or die "input must be a 9x9 matrix\n";
    push @m, \@row;
}
@m == 9 or die "input must be a 9x9 matrix\n";

check_constraints(\@m) or die "input violates constraints\n";

# solve and show all solutions
solve(\@m);


sub solve {
    my($m) = @_;

    for my $r (0 .. $#m) {
        for my $c (0 .. $#{$m->[0]}) {
            if ($m->[$r][$c] == 0) {                # found an unsolved position
                for my $try (1 .. 9) {              # try each of 1..9
                    my $copy = clone($m);           # make a copy
                    $copy->[$r][$c] = $try;         # try each number
                    if (check_constraints($copy)) { # this attempt is good
                        solve($copy);               # recurse to solve the rest
                    }
                }
                return;                             # trim the tree, we have tried 1..9
            }
        }
    }

    # all solved, output result
    for (@$m) {
        say "[ ", join(" ", @$_), " ]";
    }
    say "";         # to separate different solutions
}

# check no position violates the three rules
sub check_constraints {
    my($m) = @_;

    # a) Each row must have the numbers 1-9 occurring just once.
    for my $c (0 .. $#{$m->[0]}) {
        my @found;
        for my $r (0 .. $#m) {
            my $v = $m->[$r][$c];
            if ($v > 0 && defined($found[$v])) {
                return 0;
            }
            else {
                $found[$v] = 1;
            }
        }
    }

    # b) Each column must have the numbers 1-9 occurring just once.
    for my $r (0 .. $#m) {
        my @found;
        for my $c (0 .. $#{$m->[0]}) {
            my $v = $m->[$r][$c];
            if ($v > 0 && defined($found[$v])) {
                return 0;
            }
            else {
                $found[$v] = 1;
            }
        }
    }

    # c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
    for (my $r0 = 0; $r0 <= $#m; $r0 += 3) {
        for (my $c0 = 0; $c0 <= $#{$m->[0]}; $c0 += 3) {
            my @found;
            for my $r ($r0 .. $r0+2) {
                for my $c ($c0 .. $c0+2) {
                    my $v = $m->[$r][$c];
                    if ($v > 0 && defined($found[$v])) {
                        return 0;
                    }
                    else {
                        $found[$v] = 1;
                    }
                }
            }
        }
    }

    return 1;
}
