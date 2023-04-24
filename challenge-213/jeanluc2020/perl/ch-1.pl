#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-213/#TASK1
#
# Task 1: Fun Sort
# ================
#
# You are given a list of positive integers.
#
# Write a script to sort the all even integers first then all odds in ascending order.
#
## Example 1
##
## Input: @list = (1,2,3,4,5,6)
## Output: (2,4,6,1,3,5)
#
## Example 2
##
## Input: @list = (1,2)
## Output: (2,1)
#
## Example 3
##
## Input: @list = (1)
## Output: (1)
#
############################################################
##
## discussion
##
############################################################
#
# This just requires the right sort function. It has to sort
# even numbers first and odd numbers last, and inside those
# sort by size. The former we can get by comparing the
# numbers modulo 2, the latter by comparing the numbers
# directly, so the sort function becomes really short.

use strict;
use warnings;

fun_sort(1,2,3,4,5,6);
fun_sort(1,2);
fun_sort(1);

sub fun_sort {
   my @list = @_;
   print "Input: (" . join(",", @list) . ")\n";
   my @sorted_list = sort { ($a % 2) <=> ($b % 2)  ||  $a <=> $b } @list;
   print "Output: (" . join(",", @sorted_list) . ")\n";
}
