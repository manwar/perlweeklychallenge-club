#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-382/#TASK1
#
# Task 1: Hamiltonian Cycle
# =========================
#
# You are given a target number.
#
# Write a script to arrange all the whole numbers from 1 up to the given target
# number into a circle so that every pair of side-by-side numbers adds up to a
# perfect square. Please make sure, the last number and the first must also add
# up to a square.
#
## Example 1
##
## Input: $n = 32
## Output: 1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18,
## 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15
##
## 1  + 8  = 9
## 8  + 28 = 36
## 28 + 21 = 49
## 21 + 4  = 25
## 4  + 32 = 36
## 32 + 17 = 49
## 17 + 19 = 36
## 19 + 30 = 49
##
## so on, all the way through the sequence.
#
## Example 2
##
## Input: $n = 15
## Output: ()
##
## No valid circular list of numbers exists.
#
## Example 3
##
## Input: $n = 34
## Output: 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14, 22,
## 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3
#
############################################################
##
## discussion
##
############################################################
#
# We recursively try to find a hamiltonian cycle:
# - We pick the "1" at the beginning as the current last element
# - from all remaining numbers in the 1..$n list, we pick each one
# - if adding it to the last element creates a square, we recursively check
#   if we can turn it into a hamiltonian cycle, with the new last element
# - if we have a hamiltonian cycle, we are done, otherwise backtrack and
#   check for other potential solutions until we run out of possibilities

use v5.36;

hamiltonian_cycle(32);
hamiltonian_cycle(15);
hamiltonian_cycle(34);

sub hamiltonian_cycle($n) {
    say "Input $n";
    my @numbers = (1..$n);
    say join(", ", @numbers);
    my @seq = ();
    push @seq, shift @numbers;
    my @found = find_hamiltonian_cycle(0, $seq[0], @numbers);
    push @seq, @found;
    return say "Output: (" . join(", ", @seq) . ")" if @found;
    say "Output: ()";
}

sub find_hamiltonian_cycle($indent, $last, @rest) {
    if(scalar(@rest) == 1) {
        return @rest if is_square($last + $rest[0]) && is_square($rest[0] + 1);
        return ();
    }
    foreach my $i (0..$#rest) {
        next unless is_square($last + $rest[$i]);
        my @found = find_hamiltonian_cycle($indent + 1, $rest[$i], @rest[0..$i-1, $i+1..$#rest]);
        next unless @found;
        next unless is_square($found[$#found] + 1);
        return ($rest[$i], @found);
    }
    return ();
}

sub is_square($n) {
    my $root = sqrt($n);
    return $root == int($root);
}

