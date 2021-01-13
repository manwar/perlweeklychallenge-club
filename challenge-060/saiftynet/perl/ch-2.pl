#!/usr/env/perl
# Task 2 Challenge 060 Solution by saiftynet
# Find NumbersReviewed by: Ryan Thompson
# Write a script that accepts list of positive
# numbers (@L) and two positive numbers $X and 
# $Y.
# The script should print all possible numbers made by concatenating 
# the numbers from @L, whose length is exactly $X but value is less 
# than $Y.
# Example
# Input:
# @L = (0, 1, 2, 5);
# $X = 2;
# $Y = 21;
# Output:
# 10, 11, 12, 15, 20

# NOTES: Example indicates 1) duplicates are allowed
#  2) leading zeroes do not count. 

use strict; use warnings;

my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;

# uses a circular list to keep adding all elements of @L
# to string at one end, and pushing the results to the other end
# until the target string length has been reached.

my @combos=@L;                     # start with initial list
while (length $combos[0]<$X){      # until target length achieved
   my $next=shift @combos;         # take a number from top of list
   next if $next eq "0" ;          # dump if it is "0" (no leading zeros)
   
   # append each element of list to it and push the results to the other
   # end of the circular list. Also omit numbers that already exceed limit

   push @combos, map {($next.$_)<$Y?($next.$_):()} @L;
}

# print result in the format described in the task
print join ", ",@combos;

