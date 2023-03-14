#!/usr/bin/env perl

# Task 1: Keyboard Word
# Submitted by: Mohammad S Anwar
# 
# You are given an array of words.
# Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard.
# 
# Let us assume the keys are arranged as below:
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
# 
# Example 1
# Input: @words = ("Hello","Alaska","Dad","Peace")
# Output: ("Alaska","Dad")
# 
# Example 2
# Input: @array = ("OMG","Bye")
# Output: ()

use strict;
use warnings;

my @class = qw/qwertyuiop asdfghjkl zxcvbnm/;

my @output;

foreach my $word (@ARGV) {
    push @output, sprintf '"%s"', $word
        if scalar( map { $word =~ /^[$_]+$/i ? 1 : () }
                     @class );
}

printf "Output: (%s)\n", join ', ', @output;
