#!/usr/bin/perl

# Challenge 207
#
# Task 1: Keyboard Word
# Submitted by: Mohammad S Anwar
#
# You are given an array of words.
#
# Write a script to print all the words in the given array that can be types
# using alphabet on only one row of the keyboard.
#
# Let us assume the keys are arranged as below:
#
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
#
# Example 1
#
# Input: @words = ("Hello","Alaska","Dad","Peace")
# Output: ("Alaska","Dad")
#
# Example 2
#
# Input: @array = ("OMG","Bye")
# Output: ()

use Modern::Perl;
use List::Util qw( any );

my @keys = qw( qwertyuiop asdfghjkl zxcvbnm );

sub can_type_word {
    my($word) = @_;
    $word =~ s/\W//g;
    return any {($word =~ s/[$_]//gir) eq ""} @keys;
}

sub can_type {
    my(@words) = @_;
    return grep {can_type_word($_)} @words;
}

say join(" ", can_type(@ARGV));
