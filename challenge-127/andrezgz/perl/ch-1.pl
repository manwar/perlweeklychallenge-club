#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-127/
# TASK #1
#
# Disjoint Sets
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

use strict;
use warnings;
use feature 'say';

my @S1 = split /,/, shift;
my @S2 = split /,/, shift;

my (%union,%inter);
for (@S1,@S2) {
    $union{$_}++ && $inter{$_}++
}

say keys %inter ? 0 : 1;

__END__

$ perl ch-1.pl 1,2,3,4 4,6,7,8,9
0

$ perl ch-1.pl 1,3,5,7,9 0,2,4,6,8
1
