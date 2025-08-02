#!/usr/bin/env perl

# Task 1: Odd Character
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings, $s and $t. The string $t is generated using the shuffled characters of the string $s with an additional character.
# Write a script to find the additional character in the string $t..
# 
# Example 1
# Input: $s = "Perl" $t = "Preel"
# Output: "e"
# 
# Example 2
# Input: $s = "Weekly" $t = "Weeakly"
# Output: "a"
# 
# Example 3
# Input: $s = "Box" $t = "Boxy"
# Output: "y"

use strict;
use warnings;

my $s = "Perl"; my $t = "Preel";
odd_character($s, $t);

$s = "Weekly"; $t = "Weeakly";
odd_character($s, $t);

$s = "Box"; $t = "Boxy";
odd_character($s, $t);

exit 0;

sub odd_character {
    my $s = shift;
    my $t = shift;

    my %freq;
    foreach my $c (split //, $s) {
        $freq{$c}++;
    }
    foreach my $c (split //, $t) {
        $freq{$c}--;
    }
    
    printf "%s | %s -> %s\n", $s, $t, map { $_ } grep { $freq{$_} == -1 }keys %freq;

    return undef;
}
