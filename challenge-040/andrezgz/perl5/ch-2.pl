#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-040/
# Task #2
# Sort SubList
# You are given a list of numbers and set of indices belong to the list.
# Write a script to sort the values belongs to the indices.
#
# For example,
#
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
#
# Final List would look like below:
#
# List: [ 1, 4, 3, 8, 12, 10 ]

use strict;
use warnings;

my @list = (10, 4, 1, 8, 12, 3);
my @indexes = (0,2,5);

my @sorted_values = sort {$a <=> $b} @list[@indexes];

splice @list, $_, 1, shift @sorted_values for (@indexes);

print join ',', @list;
