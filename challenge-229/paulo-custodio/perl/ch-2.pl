#!/usr/bin/env perl

# Challenge 229
#
# Task 2: Two out of Three
# Submitted by: Mohammad S Anwar
#
# You are given three array of integers.
#
# Write a script to return all the elements that are present in at least 2 out
# of 3 given arrays.
# Example 1
#
# Input: @array1 = (1, 1, 2, 4)
#        @array2 = (2, 4)
#        @array3 = (4)
# Ouput: (2, 4)
#
# Example 2
#
# Input: @array1 = (4, 1)
#        @array2 = (2, 4)
#        @array3 = (1, 2)
# Ouput: (1, 2, 4)

use Modern::Perl;
use List::Util 'uniq';

my @arrays = map {[uniq split ' ', $_]} split /,/, "@ARGV";
my %count;
for (@arrays) {
    for (@$_) {
        $count{$_}++;
    }
}
say join ' ',
        map {$_->[0]}
        grep {$_->[1] >= 2}
        map {[$_, $count{$_}]}
        sort {$a <=> $b} keys %count;
