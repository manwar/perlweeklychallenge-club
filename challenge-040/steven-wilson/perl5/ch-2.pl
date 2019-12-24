#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-24
# Week: 040
# Task #2
# Sort SubList
# You are given a list of numbers and set of indices belong to the list.
# Write a script to sort the values belongs to the indices.

# For example,

# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.

# Final List would look like below:

# List: [ 1, 4, 3, 8, 12, 10 ]

use strict;
use warnings;
use feature qw/ say /;

my @list_of_numbers = ( 10, 4, 1, 8, 12, 3 );
my @set_of_indices = ( 0, 2, 5 );

say "Initial List:\t", join " ", @list_of_numbers;
say "Indices:\t", join " ", @set_of_indices;

my @sub_list = map { $list_of_numbers[$_] } @set_of_indices;
my @sorted_sub_list = sort { $a <=> $b } @sub_list;

# Put sorted values back into list at indices
map { $list_of_numbers[ $set_of_indices[$_] ] = $sorted_sub_list[$_] }
    ( 0 .. ( scalar @set_of_indices - 1 ) );

say "Final List:\t", join " ", @list_of_numbers;
