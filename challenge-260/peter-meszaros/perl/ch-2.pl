#!/usr/bin/env perl
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
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/permutations/;
use List::Util qw/uniqstr/;

my $cases = [
    'CAT',
    'GOOGLE',
    'SECRET',
];

sub dictionary_rank
{
    my $w = shift;

    my @l = permutations([split(//, $w)]);
    @l = uniqstr sort map {join('', @$_)} @l; 
    for (0..$#l) {
        return $_+1 if $l[$_] eq $w;
    }
    return undef;
}

is(dictionary_rank($cases->[0]),   3, 'Example 1');
is(dictionary_rank($cases->[1]),  88, 'Example 2');
is(dictionary_rank($cases->[2]), 255, 'Example 3');
done_testing();

exit 0;

