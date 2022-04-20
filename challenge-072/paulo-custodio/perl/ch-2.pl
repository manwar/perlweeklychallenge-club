#!/usr/bin/env perl

# Challenge 072
#
# TASK #2 › Lines Range
# Submitted by: Mohammad S Anwar
# You are given a text file name $file and range $A - $B where $A <= $B.
#
# Write a script to display lines range $A and $B in the given file.
#
# Example
# Input:
#     $ cat input.txt
#     L1
#     L2
#     L3
#     L4
#     ...
#     ...
#     ...
#     ...
#     L100
# $A = 4 and $B = 12
# Output:
#     L4
#     L5
#     L6
#     L7
#     L8
#     L9
#     L10
#     L11
#     L12

use Modern::Perl;
use Tie::File;

my($filename, $A, $B) = @ARGV;
tie my @lines, 'Tie::File', $filename, autochomp=>0
    or die "open $filename: $!\n";
print @lines[$A-1..$B-1];
