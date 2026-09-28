#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-393/#TASK1
#
# Task 1: Pythagoras Multiplied
# =============================
#
# You are given a positive integer n.
#
# Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2
# = c^2 and a, b and c are integers <= n.
#
## Example 1
##
## Input: $n = 20
## Output: 12
##
## (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
## (8,6,10), (8,15,17), (9,12,15),(12,5,13),
## (12,9,15),(12,16,20),(15,8,17),(16,12,20)
#
## Example 2
##
## Input: $n = 7
## Output: 2
##
## (3,4,5),(4,3,5)
#
## Example 3
##
## Input: $n = 1
## Output: 0
#
## Example 4
##
## Input: $n = 15
## Output: 8
#
## Example 5
##
## Input: $n = 30
## Output: 22
#
############################################################
##
## discussion
##
############################################################
#
# We simply create all possible combinations for a, b and c and count
# the ones where a^2 + b^2 == c^2.

use v5.36;


pythagorasmultiplied(20);
pythagorasmultiplied(7);
pythagorasmultiplied(1);
pythagorasmultiplied(15);
pythagorasmultiplied(30);

sub pythagorasmultiplied($n) {
    say "Input: $n";
    my $count = 0;
    foreach my $i (1..$n) {
        foreach my $j (1..$n) {
            foreach my $k (1..$n) {
                if($i*$i + $j*$j == $k*$k) {
                    $count++;
                }
            }
        }
    }
    say "Output: $count";
}

