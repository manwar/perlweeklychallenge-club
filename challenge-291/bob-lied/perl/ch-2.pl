#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 291 Task 2 Poker Hand Rankings
#=============================================================================
# A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers,
# no wild cards. An ace can rank either high or low.
# Write a script to determine the following three things:
# 1. How many different 5-card hands can be dealt?
# 2. How many different hands of each of the 10 ranks can be dealt?
#    See here for descriptions of the 10 ranks of Poker hands:
#    https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
# 3. Check the ten numbers you get in step 2 by adding them together
#    and showing that they're equal to the number you get in step 1.
#=============================================================================

use v5.40;

use Math::Counting qw/:big/;
use List::Util qw/sum/;

pokerHands();

# https://brilliant.org/wiki/math-of-poker/
sub pokerHands()
{
    my %hand;

    my $possible = bcomb(52,5);

    # High card. Select 5 distinct ranks out of 13, C(13,5). But 10 of those
    # form a straight, so subtract those. Pick a suit for each card, 4^5.
    # But 4 of those form a flush, so subtract those.
    $hand{"High card"} = (bcomb(13,5)-10) * (bcomb(4,1)**5 -4);

    # One pair. Select a rank, C(13,1). Pick two out of four suits, C(4,2).
    # Pick 3 ranks from the remaining 12, C(12,3). Select a suit for each
    # of the 3 other cards, 4**3.
    $hand{"One pair"} = bcomb(13,1) * bcomb(4,2) * bcomb(12,3) * bcomb(4,1)**3;

    # Two Pairs. Select two ranks, C(13,2). Pick suits, twice. That's four
    # cards, so for the fifth card, select one of the eleven remaining ranks,
    # and a suit for it.
    $hand{"Two pair"} = bcomb(13,2) * bcomb(4,2)**2 * bcomb(11,1) * bcomb(4,1);

    # Three of a kind. Select a rank, C(13,1). Pick three out of four suits,
    # C(4,3). Then, two of the remaining 12 ranks, twice.
    $hand{"Three of a kind"} = bcomb(13,1) * bcomb(4,3) * bcomb(12,2)*bcomb(4,1)** 2;

    # Straight. Must begin with A..10, so 10 possibilities. Choose 4 suits,
    # but subtract the four ways that would give us a flush.
    $hand{"Straight"} = bcomb(10,1) * ( bcomb(4,1)**5 - 4 );

    # Flush. Choose 5 distinct ranks, but subtract the ones that would give
    # a straight. Select one of four suits.
    $hand{"Flush"} = (bcomb(13,5)-10) * bcomb(4,1);

    # Full House. Choose a rank for the three; pick three of four suits for
    # them. Choose a rank for the pair (different from the triplet), and
    # choose two suits for them.
    $hand{"Full house"} = bcomb(13,1)*bcomb(4,3) * bcomb(12,1)*bcomb(4,2);

    # Four of a kind. Choose a rank. There is only one way to assign suits.
    # Then one of 12 remaining ranks for the last card, with four possible suits.
    $hand{"Four of a kind"} = bcomb(13,1)*bcomb(4,4) * bcomb(12,1)*bcomb(4,1);

    # Straight flush. Pick a start from A..10. Four possible suits. Subtract
    # the four royal flushes.
    $hand{"Straight flush"} = bcomb(10,1)*bcomb(4,1) - 4;

    # Royal flush. Four possibilities.
    $hand{"Royal flush"} = 4;

    for my $h ( sort { $hand{$a} <=> $hand{$b} } keys %hand )
    {
        printf("%20s %12d\n", $h, $hand{$h});
    }

    my $sum = sum(values %hand);
    printf("%20d =?= %8d\n", $sum, $possible);
}
