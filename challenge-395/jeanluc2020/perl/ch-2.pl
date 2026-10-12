#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-395/#TASK2
#
# Task 2: Word Squares
# ====================
#
# You are given a list of equal lengths words.
#
# Write a script to arrange a set of words into a grid that reading across any
# row gives the exact same word as reading down its corresponding column.
#
## Example 1
##
## Input: @words = ("MA", "AM", "MY", "ME")
## Output: ("MA", "AM")
##
##     M A
##     A M
#
## Example 2
##
## Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
## Output: ("SUN", "USE", "NET")
##
##     S U N
##     U S E
##     N E T
#
## Example 3
##
## Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
## Output: ("BOAT", "OGRE", "AREA", "TEAL")
##
##     B O A T
##     O G R E
##     A R E A
##     T E A L
#
## Example 4
##
## Input: @words = ("CARD", "AREA", "REAR", "DART")
## Output: ("CARD", "AREA", "REAR", "DART")
##
##     C A R D
##     A R E A
##     R E A R
##     D A R T
#
## Example 5
##
## Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
## Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")
##
##     H E A R T
##     E M B E R
##     A B U S E
##     R E S I N
##     T R E N D
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible permutations of the words in the list. We check
# whether we found a valied result for the first few elements of the
# permutation, and we continue our search otherwise.

use v5.36;
use Algorithm::Combinatorics qw(permutations);

sub word_squares(@words) {
    say "Input: (" . join(", ", map { "\"$_\"" } @words) . ")";
    my $length = length($words[0]);
    foreach my $permutation (permutations(\@words)) {
        my @p = @$permutation;
        return say "Output: (" . join(", ", map { "\"$_\"" } @p[0..$length-1]) . ")"
            if is_valid_permutation($length, @$permutation);
    }
    die "Didn't find a valid permutation";
}

sub is_valid_permutation($len, @permutation) {
    foreach my $i (0..$len-1) {
        my $column = join("", map { substr($_, $i, 1) } @permutation[0..$len-1]);
        my $row = $permutation[$i];
        return 0 unless $row eq $column;
    }
    return 1;
}

word_squares("MA", "AM", "MY", "ME");
word_squares("SUN", "USE", "NET", "SEE", "TEN");
word_squares("BOAT", "TEAL", "AREA", "TSAR", "OGRE");
word_squares("CARD", "AREA", "REAR", "DART");
word_squares("HEART", "TREND", "EMBER", "RESIN", "ABUSE");
