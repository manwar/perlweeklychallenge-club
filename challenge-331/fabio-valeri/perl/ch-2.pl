#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';


# Task 2: Buddy Strings
# Submitted by: Mohammad Sajid Anwar
#
# You are given two strings, source and target.
# Write a script to find out if the given strings are Buddy Strings.
# If swapping of a letter in one string make them same as the other then they are `Buddy Strings`.
#
# Example 1
# Input: $source = "fuck"
#        $target = "fcuk"
# Output: true
# The swapping of 'u' with 'c' makes it buddy strings.
#
# Example 2
# Input: $source = "love"
#        $target = "love"
# Output: false
#
# Example 3
# Input: $source = "fodo"
#        $target = "food"
# Output: true
#
# Example 4
# Input: $source = "feed"
#        $target = "feed"
# Output: true


# Function to check if two strings are buddy strings
sub are_buddy_strings {
    my ($source, $target) = @_;

    # Must be same length
    return 0 if length($source) != length($target);

    # Find differences
    my @diff_positions = ();
    for my $i (0 .. length($source) - 1) {
        if (substr($source, $i, 1) ne substr($target, $i, 1)) {
            push @diff_positions, $i;
        }
    }

    # Case 1: No differences - strings are identical
    if (@diff_positions == 0) {
        # Check if source has duplicate characters (can swap identical chars)
        my %char_count = ();
        for my $char (split //, $source) {
            $char_count{$char}++;
            return 1 if $char_count{$char} >= 2;  # Found duplicate
        }
        return 0;  # No duplicates, can't swap
    }

    # Case 2: Exactly 2 differences
    elsif (@diff_positions == 2) {
        my ($pos1, $pos2) = @diff_positions;
        # Check if swapping these positions makes strings equal
        return (substr($source, $pos1, 1) eq substr($target, $pos2, 1) &&
                substr($source, $pos2, 1) eq substr($target, $pos1, 1));
    }

    # Case 3: More than 2 differences - impossible with single swap
    else {
        return 0;
    }
}

# Test cases from the problem
my @test_cases = (
              ["fuck", "fcuk", 1, "Swapping 'u' with 'c'"]
             ,["love", "love", 0, "Identical with no duplicates"]
             ,["fodo", "food", 1, "Swapping 'd' with 'o'"]
             ,["feed", "feed", 1, "Identical with duplicate 'e'"]
             ,["abc" , "def" , 0, "Completely different"]
             ,["abcd", "abc" , 0, "Different lengths"]
             ,["ab"  , "ba"  , 1, "Simple swap"]
             ,["aa"  , "aa"  , 1, "Identical with duplicates"]
             ,["abc" , "acb" , 1, "Swap b and c"]
             ,["abcd", "badc", 0, "Too many differences"]
);

say "Testing Buddy Strings:\n";

foreach my $test (@test_cases) {
    my ($source, $target, $expected, $description) = @$test;
    my $result = are_buddy_strings($source, $target);
    my $status = ($result == $expected) ? "OK" : "ERROR";

    printf "%s Source: %-6s Target: %-6s => %s (Expected: %s)  %s\n"
           , $status, "\"$source\"", "\"$target\""
           , $result ? "true" : "false"
           , $expected ? "true" : "false"
           , $description
           f;
}

# Command line testing
if (@ARGV >= 2) {
    say "\nCommand line test:";
    my $result = are_buddy_strings($ARGV[0], $ARGV[1]);
    say "Source: \"$ARGV[0]\", Target: \"$ARGV[1]\" => " . ($result ? "true" : "false");
}
