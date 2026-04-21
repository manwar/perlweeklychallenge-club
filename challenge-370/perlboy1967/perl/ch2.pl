#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-370#TASK2>

Author: Niels 'PerlBoy' van Dijke

Created with Google Gemini coding assistence.
Added anagram check without A.I.

Task 2: Scramble String
Submitted by: Roger Bell_West

You are given two strings A and B of the same length.

Write a script to return true if string B is a scramble of string A
otherwise return false.

String B is a scramble of string A if A can be transformed into B by a 
single (recursive) scramble operation.

A scramble operation is:

- If the string consists of only one character, return the string.
- Divide the string X into two non-empty parts.
- Optionally, exchange the order of those parts.
- Optionally, scramble each of those parts.
- Concatenate the scrambled parts to return a single string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;

use strict;
use warnings;

sub isScramble {
    my ($s1, $s2) = @_;
    state %memo;

    # --- Test 1: Identity ---
    # If they are already the same, they are definitely scrambles.
    return true if $s1 eq $s2;

    # --- Test 2: Length Consistency ---
    # Scrambles must have the same length.
    return false if length($s1) != length($s2);

    # --- Memoization Lookup ---
    # Check if we have already calculated this specific pair.
    my $key = "$s1|$s2";
    return boolean($memo{$key}) if exists $memo{$key};

    # --- Test 3: Anagram Pruning (The "Gold" Optimization) ---
    # If the sorted characters don't match, they cannot be scrambles.
    # This prevents the recursion from blowing up on impossible pairs.
    if (join('', sort split //, $s1) ne join('', sort split //, $s2)) {
        return boolean($memo{$key} = 0);
    }

    my $len = length($s1);

    # --- Recursive Step ---
    # Split the string at every possible position 'i'
    for (my $i = 1; $i < $len; $i++) {
        
        # Case A: Parts were NOT swapped at this level
        # Check: s1[prefix] == s2[prefix] AND s1[suffix] == s2[suffix]
        if (isScramble(substr($s1, 0, $i), substr($s2, 0, $i)) &&
            isScramble(substr($s1, $i),    substr($s2, $i))) {
            return boolean($memo{$key} = 1);
        }

        # Case B: Parts WERE swapped at this level
        # Check: s1[prefix] == s2[suffix] AND s1[suffix] == s2[prefix]
        if (isScramble(substr($s1, 0, $i), substr($s2, $len - $i)) &&
            isScramble(substr($s1, $i),    substr($s2, 0, $len - $i))) {
            return boolean($memo{$key} = 1);
        }
    }

    # If no split/swap combination works, it's not a scramble.
    return boolean($memo{$key} = 0);
}

is(isScramble(qw(abc acb)),true,'Example 1');
is(isScramble(qw(abcd cdba)),true,'Example 2');
is(isScramble(qw(hello hiiii)),false,'Example 3');
is(isScramble(qw(ateer eater)),true,'Example 4');
is(isScramble(qw(abcd bdac)),false,'Example 5');

done_testing;
