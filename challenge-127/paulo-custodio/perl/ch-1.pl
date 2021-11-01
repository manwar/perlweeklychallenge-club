#!/usr/bin/env perl

# Challenge 127
#
# TASK #1 > Disjoint Sets
# Submitted by: Mohammad S Anwar
# You are given two sets with unique integers.
#
# Write a script to figure out if they are disjoint.
#
# The two sets are disjoint if they don't have any common members.
#
# Example
# Input: @S1 = (1, 2, 5, 3, 4)
#        @S2 = (4, 6, 7, 8, 9)
# Output: 0 as the given two sets have common member 4.
#
# Input: @S1 = (1, 3, 5, 7, 9)
#        @S2 = (0, 2, 4, 6, 8)
# Output: 1 as the given two sets do not have common member.

use Modern::Perl;
use Set::Intersection;

my @s1 = split(' ', scalar(<>));
my @s2 = split(' ', scalar(<>));
my @intersection = get_intersection(\@s1, \@s2);
say @intersection ? 0 : 1;
