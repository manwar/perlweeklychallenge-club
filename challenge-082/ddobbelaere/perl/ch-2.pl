#!/usr/bin/perl

=begin
https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/

TASK #2 › Interleave String
Submitted by: Mohammad S Anwar

You are given 3 strings; $A, $B and $C.

Write a script to check if $C is created by interleave $A and $B.

Print 1 if check is success otherwise 0.
Example 1:

Input:
    $A = "XY"
    $B = "X"
    $C = "XXY"

Output: 1

EXPLANATION

"X" (from $B) + "XY" (from $A) = $C

Example 2:

Input:
    $A = "XXY"
    $B = "XXZ"
    $C = "XXXXZY"

Output: 1

EXPLANATION

"XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C

Example 3:

Input:
    $A = "YX"
    $B = "X"
    $C = "XXY"

Output: 0
=cut

use v5.30;
use warnings;

sub can_interleave {
    my ($A, $B, $C) = @_;
    ($A eq '' && $B eq '' && $C eq '')
    || (length $A && substr($A,-1) eq substr($C,-1) && can_interleave(substr($A,0,-1), $B, substr($C,0,-1)))
    || (length $B && substr($B,-1) eq substr($C,-1) && can_interleave($A, substr($B,0,-1), substr($C,0,-1)));
}

while (<DATA>) {
    next if /^#/;
    /(\S*)\s*(\S*)\s*(\S*)\s*([01])/;
    my ($A, $B, $C, $expected) = ($1, $2, $3, $4);

    $expected == can_interleave($A, $B, $C) || die "Error for (A,B,C)=$A,$B,$C. Expected $expected.";
}

__DATA__
# Test data of the form $A $B $C $output.
XY X XXY 1
XXY XXZ XXXXZY 1
YX X XXY 0
ABCDEF ABCCDEF AABBCCDEFCDEF 1
ABCCDEF ABCDEF AABBCCDEFCDEF 1