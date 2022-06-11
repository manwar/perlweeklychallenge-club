#!/usr/bin/env perl

# Challenge 058
#
# TASK #2 › Ordered Lineup
# Reviewed by Ryan Thompson
# Write a script to arrange people in a lineup according to how many taller
# people are in front of each person in line. You are given two arrays. @H is a
# list of unique heights, in any order. @T is a list of how many taller people
# are to be put in front of the corresponding person in @H. The output is the
# final ordering of people’s heights, or an error if there is no solution.
#
# Here is a small example:
#
# @H = (2, 6, 4, 5, 1, 3) # Heights
# @T = (1, 0, 2, 0, 1, 2) # Number of taller people in front
# The ordering of both arrays lines up, so H[i] and T[i] refer to the same
# person. For example, there are 2 taller people in front of the person with
# height 4, and there is 1 person in front of the person with height 1.
#
# Here is a diagram of the input arrays @H and @T:
#
#
#
# Finally, here is one possible solution that satisfies @H and @T:
#
#
#
# As per the last diagram, your script would then output the ordering
# (5, 1, 2, 6, 3, 4) in this case. (The leftmost element is the “front” of the
# array.)
#
# Here’s a 64-person example, with answer provided:
#
# # Heights
# @H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
#       34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
#       48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
#        5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);
#
# # Number taller people in front
# @T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
#       29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
#       13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
#        2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);
#
# # Expected answer
# @A = (35, 23,  5, 64, 37,  9, 13, 25, 16, 44, 50, 40,  2, 27, 36,  6,
#       18, 54, 20, 39, 56, 45, 12, 47, 17, 33, 55, 30, 26, 51, 42, 53,
#       49, 41, 32, 15, 22, 60, 14, 46, 24, 59, 10, 28, 62, 38, 58, 63,
#        8, 48,  4,  7, 31, 19, 61, 43, 57, 11,  1, 34, 21, 52, 29,  3);
# You’re free to come up with your own inputs. Here is a 1000-person list,
# if you like!

use Modern::Perl;
use List::Util qw( zip );

my @H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
         34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
         48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
          5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);

my @T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
         29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
         13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
          2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);

# zip height and taller
my @HT = zip(\@H, \@T);

# reverse sort by height
@HT = sort {$b->[0] <=> $a->[0]} @HT;

# iterate through the indices
for my $i (0 .. $#HT) {

    # check if we need more people in front than are taller
    if ($HT[$i][1] > $i) {
        die "no solution\n";
    }

    # find position to move person
    my $j = $HT[$i][1];
    if ($i != $j) {
        # remove from $i and insert in $j
        my $person = splice(@HT, $i, 1);
        splice(@HT, $j, 0, $person);
    }
}

say join(", ", map {$_->[0]} @HT);
