#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

################################################################################
# A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no
# wild cards. An ace can rank either high or low.
# 
# Write a script to determine the following three things:
# 
# 1. How many different 5-card hands can be dealt?
#    Combinations: n!/r!(n-r)!
# 2. How many different hands of each of the 10 ranks can be dealt?
#    See here for descriptions of the 10 ranks of Poker hands:
#    https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
# 3. Check the ten numbers you get in step 2 by adding them together
#    and showing that they're equal to the number you get in step 1.
################################################################################

# Gather factorials of all natural numbers (including
# zero) up to and including 52
my @fact = multi_factorial(0 .. 52);

# Get a count of all possible five-card draws
my $draws = nCr_t(\@fact, 52, 5);

my $sum = 0;

# Probabilities taken in part from 
# https://en.wikipedia.org/wiki/Poker_probability .
# Terms with an 'r' of 1 and other arithmetic have
# been simplified
my @hands = (
    # Five of a kind are impossible with no wild cards
    [
        "2A: Five of a kind",
        0
    ],

    [
        "2B: Straight Flush (incl. Royal Flush)",
        40
    ],

    # Four of each rank, plus one other remaining card
    [
        "2C: Four of a kind",
        nCr_t(\@fact, 4, 4) * 624 
    ],

    [
        "2D: Full house",
        nCr_t(\@fact, 4, 3) * nCr_t(\@fact, 4, 2) * 156
    ],

    [
        "2E: Flush",
        nCr_t(\@fact, 13, 5) * 4 - 40
    ],

    [
        "2F: Straight",
        10200
    ],

    [
        "2G: Three of a kind",
        nCr_t(\@fact, 4, 3) * nCr_t(\@fact, 12, 2) * 208
    ],

    [
        "2H: Two pair",
        (nCr_t(\@fact, 4, 2) ** 2) * nCr_t(\@fact, 13, 2) * 44 
    ],

    [
        "2I: One pair",
        nCr_t(\@fact, 4, 2) * nCr_t(\@fact, 12, 3) * 832
    ],

    # No pairs, no straight, nothing
    [
        "2J: High card",
        (nCr_t(\@fact, 13, 5) - 10) * 1020
    ],
);

print("\n");
printf(
    "1. Potential five-card draws overall: %d\n",
    $draws
);

print("2.:\n");
foreach my $hand (@hands){
    $sum += $hand->[1];
    printf("    %s:\n        %d\n", $hand->[0], $hand->[1]);
}
printf("\nTotal: %d <-> Possible draws: %d\n\n", $sum, $draws);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calcuclate the number of combinations of n things taken r at a time, using a
# pre-generated table of factorials
# Takes three arguments:
# * A ref to an array of factorials that must be large enough to accommodate
#   n, and in which each index must correspond to the factorial that has been
#   pre-calculated (e.g. [ 1, 1, 2, 6, 24, 120, ... ] )
# * The number of things (n) in the set (e.g 52 )
# * The number of things (r) to be take from the set (e.g. 5 )
# Returns:
# * The number of combinations that can be made by taking r things from the set
#   of n (e.g. 2598960 )
################################################################################
sub nCr_t{
    my ($table, $n, $r) = @ARG;

    # n!/(r!(n-r)!)
    return($table->[$n] / ($table->[$r] * $table->[$n - $r]));

}



################################################################################
# Calculate the factorials of a specified list of unique integers
# Takes one argument:
# * The list of unique integers whose factorial are desired (e.g.
#   ( 9, 4, 1, 7 ) )
# Returns:
# * A list of factorials calculated from the integers in the list provided, and
#   presented in the same order (e.g. ( 362880, 24, 1, 5040 ) )
################################################################################
sub multi_factorial{
    my @n_list = @ARG;

    my %index_table;
    my $f = 1;
    my @f_list;

    # Take note of the original positions of
    # the input values
    foreach my $i (0 .. $#n_list){
        $index_table{$n_list[$i]} = $i;
    }

    # Sort the list of input values in
    # ascending order
    @n_list = sort({ $a <=> $b } @n_list);

    # Zero is a special case...
    if($n_list[0] == 0){
        $f_list[$index_table{0}] = 1;
        shift(@n_list);
    }

    # Calculate the factorial of the largest
    # input value...
    for(1 .. $n_list[-1]){
        $f *= $_;

        # ...taking note of the factorials of
        # smaller input values along the way
        if($_ == $n_list[0]){
            $f_list[$index_table{$_}] = $f;
            shift(@n_list);
        }
    }

    return(@f_list);

}



