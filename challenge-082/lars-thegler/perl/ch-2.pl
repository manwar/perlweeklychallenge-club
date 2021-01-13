#! /usr/bin/env perl

use Modern::Perl;
use Data::Printer;

# TASK #2 › Interleave String
# Submitted by: Mohammad S Anwar
# You are given 3 strings; $A, $B and $C.

# Write a script to check if $C is created by interleave $A and $B.

# Print 1 if check is success otherwise 0.

# Example 1:
# Input:
#     $A = "XY"
#     $B = "X"
#     $C = "XXY"

# Output: 1
# EXPLANATION
# "X" (from $B) + "XY" (from $A) = $C
# Example 2:
# Input:
#     $A = "XXY"
#     $B = "XXZ"
#     $C = "XXXXZY"

# Output: 1
# EXPLANATION
# "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
# Example 3:
# Input:
#     $A = "YX"
#     $B = "X"
#     $C = "XXY"

# Output: 0

my ($A, $B, $C) = @ARGV;


my %interleaves;
$interleaves{$_}++ for interleave($A, $B), interleave($B, $A);

say exists $interleaves{$C} ? 1 : 0;

sub interleave {
    my ($a, $b) = @_;
    my @interleaves;
    for my $i (0..length $a) {
       my $s = $a;
       $s =~ s/^(.{$i})(.*)/$1$b$2/;
       push @interleaves, $s;
    }
    return @interleaves;
}