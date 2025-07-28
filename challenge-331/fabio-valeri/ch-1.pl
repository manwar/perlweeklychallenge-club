#!/usr/bin/perl 

use strict;
use warnings;
use feature 'say';

# Task 1: Last Word
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# Write a script to find the length of last word in the given string.
# 
# Example 1
# Input: $str = "The Weekly Challenge"
# Output: 9 
# 
# Example 2
# Input: $str = "   Hello   World    "
# Output: 5
# 
# Example 3
# Input: $str = "Let's begin the fun"
# Output: 3


# Function to count the number of letters of the last word
sub last_word {
    my $input = shift;
    
    # Read last word considering empty spaces
    $input =~ /(\S+)\s*$/;
    # compute length
    return length($1);
        
}

# Test cases
my @test_strings = (
                     "The Weekly Challenge"
                    , "Hello   World    "
                    , "Let's begin the fun"
);

# Test the function with all test cases
say "Testing last_word function:\n";

foreach my $test (@test_strings) {
    my $result = last_word($test);
    printf "Input:  %-25s => Output: %s\n", "\"$test\"", "\"$result\"";
}

# Also allow command line testing
if (@ARGV) {
    say "\nCommand line input:";
    my $result = last_word($ARGV[0]);
    say "Input:  \"$ARGV[0]\" => Output: \"$result\"";
  }

