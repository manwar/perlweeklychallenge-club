#!/usr/bin/env raku

# Task #1 Zero Matrix
# Submitted by: Mohammad S Anwar

# You are given a matrix of size M x N having only 0s and 1s.

# Write a script to set the entire row and column to 0 if an element is 0.

# Example 1
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 1, 1]

# Output: [0, 0, 0]
#         [1, 0, 1]
#         [1, 0, 1]

# Example 2
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 0, 1]

# Output: [0, 0, 0]
#         [1, 0, 1]
#         [0, 0, 0]

my @matrix = [1 xx 11] xx 11;

@matrix[5][5] = 0;

my %rows;
my %cols;

for @matrix.keys -> $r { 
    for @matrix[0].keys -> $c {
        if @matrix[$r][$c] == 0 {
            %rows{$r} = True;
            %cols{$c} = True;
        }
    }
}

@matrix[$_] = [0 xx @matrix[0]] for %rows.keys;
@matrix.map(-> $r {$r[$_] = 0}) for %cols.keys;

say @matrix.join("\n");
