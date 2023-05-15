#!/usr/bin/perl

# Challenge 214
#
# Task 1: Rank Score
# Submitted by: Mohammad S Anwar
#
# You are given a list of scores (>=1).
#
# Write a script to rank each score in descending order. First three will get
# medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the
# ranking number.
#
#     Using the standard model of giving equal scores equal rank, then
#     advancing that number of ranks.
#
#
# Example 1
#
# Input: @scores = (1,2,4,3,5)
# Output: (5,4,S,B,G)
#
# Score 1 is the 5th rank.
# Score 2 is the 4th rank.
# Score 4 is the 2nd rank i.e. Silver (S).
# Score 3 is the 3rd rank i.e. Bronze (B).
# Score 5 is the 1st rank i.e. Gold (G).
#
# Example 2
#
# Input: @scores = (8,5,6,7,4)
# Output: (G,4,B,S,5)
#
# Score 8 is the 1st rank i.e. Gold (G).
# Score 4 is the 4th rank.
# Score 6 is the 3rd rank i.e. Bronze (B).
# Score 7 is the 2nd rank i.e. Silver (S).
# Score 4 is the 5th rank.
#
# Example 3
#
# Input: @list = (3,5,4,2)
# Output: (B,G,S,4)
#
# Example 4
#
# Input: @scores = (2,5,2,1,7,5,1)
# Output: (4,S,4,6,G,S,6)

use Modern::Perl;

# in:  list of numbers
# out: list of items with the same value reverse-ordered by value
#      each item is [index, value]
sub rank_values {
    my(@list) = @_;
    my @sorted = reverse sort {$a->[1] <=> $b->[1]}
                 map {[$_, $list[$_]]} 0..$#list;
    my @output;
    while (@sorted) {
        my @head;
        my $first_value = $sorted[0][1];
        while (@sorted && $sorted[0][1] == $first_value) {
            push @head, shift @sorted;
        }
        push @output, \@head;
    }
    return @output;
}

# in:  list of numbers
# out: corresponding list of ranking
sub standard_ranking {
    my(@list) = @_;
    my @ranked = rank_values(@list);
    my @ranks;
    my $rank = 1;
    while (@ranked) {
        my @head = @{shift @ranked};
        for (@head) {
            $ranks[$_->[0]] = $rank;
        }
        $rank += @head;
    }

    for (@ranks) {
        s/^1$/G/;
        s/^2$/S/;
        s/^3$/B/;
    }

    return @ranks;
}

say join(" ", standard_ranking(@ARGV));
