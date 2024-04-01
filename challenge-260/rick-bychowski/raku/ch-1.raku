#!/usr/bin/env raku
# Unique Occurrences
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
# This script takes input from the terminal.

my %IntCount;

sub MAIN( *@ints where .all ~~ Int ){
    for @ints.sort -> $int {
        if %IntCount{$int}:!exists {              # start of a new integer
            say 0 and exit unless &uniqueSoFar(%IntCount.values);
        }
        %IntCount{"$int"}++;

        LAST { say 0 and exit unless &uniqueSoFar(%IntCount.values); }
    }

say 1;

}

sub uniqueSoFar(@counts where .all ~~ Int ){
    if @counts.unique.elems !== @counts.elems {
        False;
    } else {
        True;
    }
}
    
=begin comment

Task 1: Unique Occurrences
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return 1 if the number of occurrences of each value in the given array is unique or 0 otherwise.
Example 1

Input: @ints = (1,2,2,1,1,3)
Output: 1

The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.

All occurrences are unique, therefore the output is 1.

Example 2

Input: @ints = (1,2,3)
Output: 0

Example 3

Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
Output: 1
=end comment
