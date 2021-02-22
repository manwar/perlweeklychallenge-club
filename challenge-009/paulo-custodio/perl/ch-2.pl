#!/usr/bin/perl

# Challenge 009
#
# Challenge #2
# Write a script to perform different types of ranking as described below:
#
# 1. Standard Ranking (1224): Items that compare equal receive the same ranking
#    number, and then a gap is left in the ranking numbers.
# 2. Modified Ranking (1334): It is done by leaving the gaps in the ranking
#    numbers before the sets of equal-ranking items.
# 3. Dense Ranking    (1223): Items that compare equally receive the same
#    ranking number, and the next item(s) receive the immediately following
#    ranking number.

use strict;
use warnings;
use 5.030;

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
    return @ranks;
}

# in:  list of numbers
# out: corresponding list of ranking
sub modified_ranking {
    my(@list) = @_;
    my @ranked = rank_values(@list);
    my @ranks;
    my $rank = 1;
    while (@ranked) {
        my @head = @{shift @ranked};
        $rank += @head - 1;
        for (@head) {
            $ranks[$_->[0]] = $rank;
        }
        $rank++;
    }
    return @ranks;
}

# in:  list of numbers
# out: corresponding list of ranking
sub dense_ranking {
    my(@list) = @_;
    my @ranked = rank_values(@list);
    my @ranks;
    my $rank = 1;
    while (@ranked) {
        my @head = @{shift @ranked};
        for (@head) {
            $ranks[$_->[0]] = $rank;
        }
        $rank++;
    }
    return @ranks;
}

say "Data:             ", join(", ", @ARGV);
say "Standard ranking: ", join(", ", standard_ranking(@ARGV));
say "Modified ranking: ", join(", ", modified_ranking(@ARGV));
say "Dense ranking:    ", join(", ", dense_ranking(@ARGV));
