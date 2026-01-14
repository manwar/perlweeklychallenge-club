#!/usr/bin/env perl

# Challenge 349
#
# Task 2: Meeting Point
# Submitted by: Mohammad Sajid Anwar
# You are given instruction string made up of U (up), D (down), L (left) and R (right).
#
# Write a script to return true if following the instruction, you meet (0,0) at any point along the sequence.
#
#
# Example 1
# Input: $path = "ULD"
# Output: false
#
# (-1,1) <- (0,1)
#    |        ^
#    v        |
# (-1,0)    (0,0)
#
# Example 2
# Input: $path = "ULDR"
# Output: true
#
#  (-1,1) <- (0,1)
#     |        ^
#     v        |
#  (-1,0) -> (0,0)
#
# Example 3
# Input: $path = "UUURRRDDD"
# Output: false
#
# (0,3) -> (1,3) -> (2,3) -> (3,3)
#   ^                          |
#   |                          v
# (0,2)                      (3,2)
#   ^                          |
#   |                          v
# (0,1)                      (3,1)
#   ^                          |
#   |                          v
# (0,0)                      (3,0)
#
# Example 4
# Input: $path = "UURRRDDLLL"
# Output: true
#
# (0,2) -> (1,2) -> (2,2) -> (3,2)
#   ^                          |
#   |                          v
# (0,1)                      (3,1)
#   ^                          |
#   |                          v
# (0,0) <- (1,0) <- (1,1) <- (3,0)
#
# Example 5
# Input: $path = "RRUULLDDRRUU"
# Output: true
#
# (0,2) <- (1,2) <- (2,2)
#   |                 ^
#   v                 |
# (0,1)             (2,1)
#   |                 ^
#   v                 |
# (0,0) -> (1,0) -> (2,1)

use Modern::Perl;

@ARGV==1 or die "usage: $0 UDLR...\n";
say passes_start($ARGV[0]) ? 'true' : 'false';

sub passes_start {
    my($moves) = @_;
    my($x, $y) = (0, 0);
    for (split //, $moves) {
        /R/ and $x++;
        /L/ and $x--;
        /U/ and $y++;
        /D/ and $y--;
        return 1 if $x==0 && $y==0;
    }
    return;
}
