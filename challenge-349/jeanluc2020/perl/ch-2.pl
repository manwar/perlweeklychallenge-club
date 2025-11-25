#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK2
#
# Task 2: Meeting Point
# =====================
#
# You are given instruction string made up of U (up), D (down), L (left) and R
# (right).
#
# Write a script to return true if following the instruction, you meet (0,0) at
# any point along the sequence.
#
## Example 1
##
## Input: $path = "ULD"
## Output: false
##
## (-1,1) <- (0,1)
##    |        ^
##    v        |
## (-1,0)    (0,0)
#
#
## Example 2
##
## Input: $path = "ULDR"
## Output: true
##
##  (-1,1) <- (0,1)
##     |        ^
##     v        |
##  (-1,0) -> (0,0)
#
#
## Example 3
##
## Input: $path = "UUURRRDDD"
## Output: false
##
## (0,3) -> (1,3) -> (2,3) -> (3,3)
##   ^                          |
##   |                          v
## (0,2)                      (3,2)
##   ^                          |
##   |                          v
## (0,1)                      (3,1)
##   ^                          |
##   |                          v
## (0,0)                      (3,0)
#
#
## Example 4
##
## Input: $path = "UURRRDDLLL"
## Output: true
##
## (0,2) -> (1,2) -> (2,2) -> (3,2)
##   ^                          |
##   |                          v
## (0,1)                      (3,1)
##   ^                          |
##   |                          v
## (0,0) <- (1,0) <- (1,1) <- (3,0)
#
#
## Example 5
##
## Input: $path = "RRUULLDDRRUU"
## Output: true
##
## (0,2) <- (1,2) <- (2,2)
##   |                 ^
##   v                 |
## (0,1)             (2,1)
##   |                 ^
##   v                 |
## (0,0) -> (1,0) -> (2,1)
#
############################################################
##
## discussion
##
############################################################
#
# We walk the path and check where we are. If we are back to
# (0, 0) at any time during the walk, we can return true already.
# In the end, if we didn't return true at some point, we can
# return false.
#
use v5.36;

meeting_point("ULD");
meeting_point("ULDR");
meeting_point("UUURRRDDD");
meeting_point("UURRRDDLLL");
meeting_point("RRUULLDDRRUU");

sub meeting_point($path) {
    say "Input: '$path'";
    my ($x, $y) = (0, 0);
    foreach my $step (split //, $path) {
        if($step eq "U") {
            $y++;
        } elsif ($step eq "D") {
            $y--;
        } elsif ($step eq "L") {
            $x--;
        } else {
            $x++;
        }
        say "($x, $y)";
        if($x == 0 and $y == 0) {
            return say "Output: true";
        }
    }
    say "Output: false";
}

