#! /usr/bin/env raku
use v6.d;

#===============================================================================
#
#         FILE: <ch-1.raku>
#
#  DESCRIPTION: A solution to the Perl Weekly Challenge 214, Challenge 1
#
#       AUTHOR: Shimon Bollinger  (deoac.shimon@gmail.com)
#     REVISION: Last modified: Fri 28 Apr 2023 04:28:06 PM EDT
#===============================================================================

=begin comment
    Task 1: Rank Score
    Submitted by: Mohammad S Anwar
    You are given a list of scores (>=1).

    Write a script to rank each score in descending order. First three will
    get medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get
    the ranking number.

    Using the standard model of giving equal scores equal rank, then advancing
    that number of ranks.


    Example 1
    Input: @scores = (1,2,4,3,5)
    Output: (5,4,S,B,G)

    Score 1 is the 5th rank.
    Score 2 is the 4th rank.
    Score 4 is the 2nd rank i.e. Silver (S).
    Score 3 is the 3rd rank i.e. Bronze (B).
    Score 5 is the 1st rank i.e. Gold (G).
    Example 2
    Input: @scores = (8,5,6,7,4)
    Output: (G,4,B,S,5)

    Score 8 is the 1st rank i.e. Gold (G).
    Score 4 is the 4th rank.
    Score 6 is the 3rd rank i.e. Bronze (B).
    Score 7 is the 2nd rank i.e. Silver (S).
    Score 4 is the 5th rank.
    Example 3
    Input: @list = (3,5,4,2)
    Output: (B,G,S,4)
    Example 4
    Input: @scores = (2,5,2,1,7,5,1)
    Output: (4,S,4,6,G,S,6)
=end comment

enum Medals « :G(1) S B »;
my @medals = (Nil, Medals::G, Medals::S, Medals::B);

subset ℕ of UInt where * > 0;

#| Handle bad input
multi sub rank-score (@scores where not (.all ~~ ℕ) ) {
    note "All scores must be integers greater than zero!";
    return Nil;
} # end of multi sub rank-score (@scores where !(.all ~~ UInt) || .any ≤ 0)

#| Handle good input!
multi sub rank-score (@scores) {
    my Int $index = 0;
    # Create a Hash where the keys are the position in the @scores array,
    # and the values are the values of the @scores array.
    my %index-with-scores = @scores.map: $index++ => *;

    # Now create an array of pairs, reverse-sorted by value. So the winner
    # (with the highest score) is at index 0.
    my @index-with-scores = %index-with-scores.sort(*.values).reverse;

    my Int $rank   = 0;
    my $prev-value = 0;
    my Int $count  = 1;
    for @index-with-scores {
        if .value == $prev-value {
            # Handle ties
            $count++;
        } else {
            # Descend the rank, usually by one 
            # (5ᵗʰ place comes after 4ᵗʰ place). 
            #
            # But after ties, we descend more than one. 
            # (e.g. if two Gold medals are given, the next winner is in 3ʳᵈ,
            #  not 2ⁿᵈ, place and receives a Bronze medal.)
            $rank += $count;
            $count = 1;
        } # end of } else
        $prev-value = .value;
        .value = $rank;
    } # end of for @index-with-scores 

    # Now sort the array on the keys - this will return the array to its
    # original order, but with ranks instead of scores at each index.
    my @index-with-ranks = @index-with-scores.sort;

    # We're only interested in the ranks, 
    # which are the values of each Pair in the array.
    my @retval = @index-with-ranks.map: |*.values;

    # Substitute G, S, or B for 1ˢᵗ, 2ⁿᵈ, and 3ʳᵈ place, respectively.
    @retval .= map: { @medals[$_] // $_ };

    # The challenge specified the output be a List, not an Array.
    return @retval.List;
} # end of sub rank-score (UInt @scores)

use Test;

is rank-score((0, 1,   2)), Nil, "Zero not allowed OK";
is rank-score((1, 2.5, 3)), Nil, "Non-integers not allowed OK";
is rank-score((1, 2,  -3)), Nil, "Negative numbers not allowed OK";

is-deeply rank-score((1,2,4,3,5)),     (5,4,S,B,G),     'Example 1 OK';
is-deeply rank-score((8,5,6,7,4)),     (G,4,B,S,5),     'Example 2 OK';
is-deeply rank-score((3,5,4,2)),       (B,G,S,4),       'Example 3 OK';
is-deeply rank-score((2,5,2,1,7,5,1)), (4,S,4,6,G,S,6), 'Example 4 OK';
