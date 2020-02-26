#!/usr/env perl
# Perl Challenge 040 Task 2
# You are given a list of numbers and set of indices belong to the list.
# Write a script to sort the values belongs to the indices

use feature 'say';

my @list= ( 10, 4, 1, 8, 12, 3 );               # list for selective sorting
my @Indices=(0,2,5);                            # list of indices to sort

say "Original list:- ",join " ",@list;          # display original list

@list[@Indices]=sort{$a <=> $b}@list[@Indices]; # sort index values

say "Modified list:- ",join " ",@list;          # display results after modification
