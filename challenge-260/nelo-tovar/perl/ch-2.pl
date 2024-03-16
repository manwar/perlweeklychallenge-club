#!/usr/bin/env perl

# The Weekly Challenge 260 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
#
# Task 2 - Dictionary Rank
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw (bsearch_index);
use Algorithm::Combinatorics qw(permutations);

my @examples = (
    'CAT', 
    'GOOGLE', 
    'SECRET',
);

sub dictionary_rank {
    my $word = shift;
    my $rank = 0;
    my @letters = split //, $word;
    my @dictionary;

    my $iter = permutations(\@letters);
    while (my $c = $iter->next) {
        push @dictionary, join '', @$c; 
    }

    @dictionary = sort @dictionary;
    $rank = bsearch_index {$word eq $_} @dictionary;

    return $rank;
}

for my $elements (@examples) {
    my $dr = dictionary_rank $elements;

    say 'Input : word = ', $elements;
    say 'Output : ', $dr;
    say ' ';
}
