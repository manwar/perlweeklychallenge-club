#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK2
#
# Task 2: Find Celebrity
# ======================
#
# You are given a binary matrix (m x n).
#
# Write a script to find the celebrity, return -1 when none found.
#
### A celebrity is someone, everyone knows and knows nobody.
#
#
## Example 1
##
## Input: @party = (
##             [0, 0, 0, 0, 1, 0],  # 0 knows 4
##             [0, 0, 0, 0, 1, 0],  # 1 knows 4
##             [0, 0, 0, 0, 1, 0],  # 2 knows 4
##             [0, 0, 0, 0, 1, 0],  # 3 knows 4
##             [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
##             [0, 0, 0, 0, 1, 0],  # 5 knows 4
##        );
## Output: 4
#
#
## Example 2
##
## Input: @party = (
##             [0, 1, 0, 0],  # 0 knows 1
##             [0, 0, 1, 0],  # 1 knows 2
##             [0, 0, 0, 1],  # 2 knows 3
##             [1, 0, 0, 0]   # 3 knows 0
##        );
## Output: -1
#
#
## Example 3
##
## Input: @party = (
##             [0, 0, 0, 0, 0],  # 0 knows NOBODY
##             [1, 0, 0, 0, 0],  # 1 knows 0
##             [1, 0, 0, 0, 0],  # 2 knows 0
##             [1, 0, 0, 0, 0],  # 3 knows 0
##             [1, 0, 0, 0, 0]   # 4 knows 0
##        );
## Output: 0
#
#
## Example 4
##
## Input: @party = (
##             [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
##             [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
##             [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
##             [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
##             [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
##             [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
##        );
## Output: 3
#
#
## Example 5
##
## Input: @party = (
##             [0, 1, 1, 0],  # 0 knows 1 and 2
##             [1, 0, 1, 0],  # 1 knows 0 and 2
##             [0, 0, 0, 0],  # 2 knows NOBODY
##             [0, 0, 0, 0]   # 3 knows NOBODY
##        );
## Output: -1
#
#
## Example 6
##
## Input: @party = (
##             [0, 0, 1, 1],  # 0 knows 2 and 3
##             [1, 0, 0, 0],  # 1 knows 0
##             [1, 1, 0, 1],  # 2 knows 0, 1 and 3
##             [1, 1, 0, 0]   # 3 knows 0 and 1
##       );
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# Since the matrix has information on each person in respect to each
# other, the mxn matrix is actually a mxm matrix. So we can use the
# number of rows and columns interchangibly, so we'll do that.
# Now we prefill an array @known_by_all with all ones, and later
# turn each value to 0 if we see one person not knowing this one.
# So in the end we know which people are known by all.
# We also count how many people everyone knows. If that number is 0,
# we remember that person in the array @knows_none.
# In the end, if multiple people or nobody at all knows none, we can
# return -1. If exactly one person knows none, we return that persons
# index if everybody knows this one. Otherwise, we couldn't find
# any celebrity and return -1 again.

use v5.36;

find_celebrity(
     [0, 0, 0, 0, 1, 0],  # 0 knows 4
     [0, 0, 0, 0, 1, 0],  # 1 knows 4
     [0, 0, 0, 0, 1, 0],  # 2 knows 4
     [0, 0, 0, 0, 1, 0],  # 3 knows 4
     [0, 0, 0, 0, 0, 0],  # 4 knows N
     [0, 0, 0, 0, 1, 0],  # 5 knows 4
     );
find_celebrity(
     [0, 1, 0, 0],  # 0 knows 1
     [0, 0, 1, 0],  # 1 knows 2
     [0, 0, 0, 1],  # 2 knows 3
     [1, 0, 0, 0]   # 3 knows 0
     );
find_celebrity(
     [0, 0, 0, 0, 0],  # 0 knows NOBODY
     [1, 0, 0, 0, 0],  # 1 knows 0
     [1, 0, 0, 0, 0],  # 2 knows 0
     [1, 0, 0, 0, 0],  # 3 knows 0
     [1, 0, 0, 0, 0]   # 4 knows 0
     );
find_celebrity(
     [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
     [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
     [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
     [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
     [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
     [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
     );
find_celebrity(
     [0, 1, 1, 0],  # 0 knows 1 and 2
     [1, 0, 1, 0],  # 1 knows 0 and 2
     [0, 0, 0, 0],  # 2 knows NOBODY
     [0, 0, 0, 0]   # 3 knows NOBODY
     );
find_celebrity(
     [0, 0, 1, 1],  # 0 knows 2 and 3
     [1, 0, 0, 0],  # 1 knows 0
     [1, 1, 0, 1],  # 2 knows 0, 1 and 3
     [1, 1, 0, 0]   # 3 knows 0 and 1
     );

sub find_celebrity(@party) {
    my @known_by_all = ();
    my @knows_none;
    foreach my $i (0..$#party) {
        push @known_by_all, 1;
    }
    foreach my $who (0..$#party) {
        my $knows_how_many = 0;
        foreach my $whom (0..$#party) {
            $knows_how_many += $party[$who]->[$whom];
            $known_by_all[$whom] = 0 unless $party[$who]->[$whom] or $who == $whom;
        }
        push @knows_none, $who unless $knows_how_many;
    }
    return say "Output: -1" unless scalar(@knows_none) == 1;
    return say "Output: $knows_none[0]" if $known_by_all[$knows_none[0]];
    return say "Output: -1";
}
