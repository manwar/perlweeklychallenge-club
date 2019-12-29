#!/usr/bin/perl
#
# Task 2: "Sort SubList
# 
# You are given a list of numbers and set of indices belong to the
# list. Write a script to sort the values belongs to the indices.
# 
# For example:
# 
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# 
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
# 
# Final List would look like below:
# List: [ 1, 4, 3, 8, 12, 10 ]
# "
# 
# My notes: looks very easy. I guess the decision is: sort in place, or
# extract items via an array slice, sort them, then update those items
# in the original array (via another array slice?).  The latter sounds
# much the easier, so let's do that:-).
# 

use v5.10;	# to get "say"
use strict;
use warnings;
#use Data::Dumper;

die "Usage: ch-2.pl ARRAYLIST INDEXLIST\n" unless @ARGV==2;
my @array = split(/,/, $ARGV[0]);
my @index = split(/,/, $ARGV[1]);

my @subarray = @array[@index];
#die Dumper \@subarray;

@subarray = sort { $a <=> $b } @subarray;
#die Dumper \@subarray;

@array[@index] = @subarray;
#die Dumper \@array;

say "List: [ ", join(', ', @array), " ]";
