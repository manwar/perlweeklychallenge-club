#!/usr/bin/env perl

# Perl Weekly Challenge 214 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-214/

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
