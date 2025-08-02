#!/usr/bin/env perl

# Task 1: Percentage of Character
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str and a character $char.
# Write a script to return the percentage, nearest whole, of given character in the given string.
# 
# Example 1
# Input: $str = "perl", $char = "e"
# Output: 25
# 
# Example 2
# Input: $str = "java", $char = "a"
# Output: 50
# 
# Example 3
# Input: $str = "python", $char = "m"
# Output: 0
# 
# Example 4
# Input: $str = "ada", $char = "a"
# Output: 67
# 
# Example 5
# Input: $str = "ballerina", $char = "l"
# Output: 22
# 
# Example 6
# Input: $str = "analitik", $char = "k"
# Output: 13

use strict;
use warnings;

my $str = "perl"; my $char = "e";
percentage($str, $char);

$str = "java"; $char = "a";
percentage($str, $char);

$str = "python"; $char = "m";
percentage($str, $char);

$str = "ada"; $char = "a";
percentage($str, $char);

$str = "ballerina"; $char = "l";
percentage($str, $char);

$str = "analitik"; $char = "k";
percentage($str, $char);

exit 0;

sub percentage {
    my $str = shift;
    my $char = shift;

    my %freq;
    $freq{$_}++
        foreach split //, $str;
    printf "str %s char %s -> perc %.0f\n",
        $str, $char,
        $freq{$char}
            ? $freq{$char}/length($str)*100
            : 0;
}
