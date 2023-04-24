#!/usr/bin/perl

# Challenge 213
#
# Task 1: Fun Sort
# Submitted by: Mohammad S Anwar
#
# You are given a list of positive integers.
#
# Write a script to sort the all even integers first then all odds in
# ascending order.
# Example 1
#
# Input: @list = (1,2,3,4,5,6)
# Output: (2,4,6,1,3,5)
#
# Example 2
#
# Input: @list = (1,2)
# Output: (2,1)
#
# Example 3
#
# Input: @list = (1)
# Output: (1)

use Modern::Perl;

my @even = sort {$a<=>$b} grep {$_%2==0} @ARGV;
my @odd = sort {$a<=>$b} grep {$_%2!=0} @ARGV;
my @result = (@even, @odd);
say "@result";
