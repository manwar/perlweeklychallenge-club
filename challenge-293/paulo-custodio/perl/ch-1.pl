#!/usr/bin/env perl

# Challenge 293
#
# Task 1: Similar Dominos
# Submitted by: Mohammad Sajid Anwar
# You are given a list of dominos, @dominos.
#
# Write a script to return the number of dominoes that are similar to any other domino.
#
# $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).
#
# Example 1
# Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
# Output: 2
#
# Similar Dominos: $dominos[0], $dominos[1]
# Example 2
# Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
# Output: 3
#
# Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

use Modern::Perl;

@ARGV or die "usage: $0 'n n' 'n n'...\n";
my @dominoes = @ARGV;
for (@dominoes) {
    $_ = [split ' ', $_];
}

say similar(@dominoes);

sub similar {
    my(@dominoes) = @_;
    my $similar = 0;

    # for each dominoe
    for my $i (0 .. $#dominoes) {
        # check if it has any similar in the other ones
        my $has_similar = 0;
        for my $j (0 .. $#dominoes) {
            next if $i == $j;
            if (same_domino($dominoes[$i], $dominoes[$j])) {
                $has_similar = 1;
                last;
            }
        }

        # count once for each dominoe
        $similar++ if $has_similar;
    }
    return $similar;
}

sub same_domino {
    my ($a, $b) = @_;
    return ($a->[0] == $b->[0] && $a->[1] == $b->[1])
        || ($a->[0] == $b->[1] && $a->[1] == $b->[0]);
}
