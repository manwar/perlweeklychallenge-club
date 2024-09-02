#!/usr/bin/env perl

# Challenge 260
#
# Task 2: Dictionary Rank
# Submitted by: Mark Anderson
#
# You are given a word, $word.
#
# Write a script to compute the dictionary rank of the given word.
# Example 1
#
# Input: $word = 'CAT'
# Output: 3
#
# All possible combinations of the letters:
# CAT, CTA, ATC, TCA, ACT, TAC
#
# Arrange them in alphabetical order:
# ACT, ATC, CAT, CTA, TAC, TCA
#
# CAT is the 3rd in the list.
# Therefore the dictionary rank of CAT is 3.
#
# Example 2
#
# Input: $word = 'GOOGLE'
# Output: 88
#
# Example 3
#
# Input: $word = 'SECRET'
# Output: 255

use Modern::Perl;
use Algorithm::Combinatorics qw(permutations);
use List::Util 'uniq';
use List::MoreUtils 'onlyidx';

say dictionary_rank(shift // "");

sub dictionary_rank {
    my($word) = @_;
    return
        1+(onlyidx {$_ eq $word}
           sort {$a cmp $b}
           uniq
           map {join '', @$_}
           permutations([split //, $word]))[0];
}
