#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_pairs = (
    # Given cases
    [
        # NOTE: this word was in the given problem set-
        # I did NOT choose it myself!
        # See: https://theweeklychallenge.org/blog/perl-weekly-challenge-331/
        "fuck",
        "fcuk"
    ],
    [
        "love",
        "love"
    ],
    [
        "fodo",
        "food"
    ],
    [
        "feed",
        "feed"
    ],

    # Additional test cases
    [
        "abba",
        "baab"
    ],
    [
        "pork",
        "perk"
    ],
    [
        "wrong",
        "length"
    ],
    [
        "same",
        "same"
    ]
);

print("\n");
foreach my $word_pair (@word_pairs){
    printf(
        "Input: \$source = \"%s\"\n       \$target = \"%s\"\nOutput: %s\n\n",
        $word_pair->[0],
        $word_pair->[1],
        are_buddy_strings(@{$word_pair}) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether two strings are Buddy Strings- strings in which swapping
# two characters (which need not be adjacent or different) within one string
# would make it identical to the other string
# Takes two arguments:
# * The first string to examine (e.g. "food")
# * The second string to examine (e.g. "fodo")
# Returns:
# * 0 if the two strings do not appear to be Buddy Strings
# * 1 if the two strings appear to be Buddy Strings (as would be the case in
#   the example above)
################################################################################
sub are_buddy_strings{
    my $string_1 = shift();
    my $string_2 = shift();

    my $len_1 = length($string_1);
    my $i;

    # Filter out a couple edge cases:
    # If the strings are different lengths, they
    # can't be Buddy Strings
    return(0)
        if($len_1 != length($string_2));
    
    # If the strings are identical, characters that
    # appear more than once could still be swapped
    if($string_1 eq $string_2){
        my %counts;

        # Count instances of each character
        for($i = 0; $i < $len_1; $i++){
            $counts{substr($string_1, $i, 1)}++;
        }

        # Determine whether any appear more than once;
        # if so, these are Buddy Strings
        foreach(keys(%counts)){
            return(1)
                if($counts{$_} > 1);
        }

        # Identical but no multiple instances of a
        # character- these are not Buddy Strings
        return(0);

    }

    # If we got here, the strings are the same length but
    # not identical
    my @mismatches;

    # Scan the two strings for mismatches and store their
    # location(s)
    for($i = 0; $i < $len_1; $i++){
        push(@mismatches, $i)
            unless(substr($string_1, $i, 1) eq substr($string_2, $i, 1));
    }

    # There should be exactly two mismatches...
    return(0)
        unless(scalar(@mismatches) == 2);

    # ...and those two mismatches should consist of a pair
    # in which each string's mismatched letter matches the
    # other string's mismatched letter at the other location
    return(0)
        unless(
            (
                substr($string_1, $mismatches[0], 1)
                eq
                substr($string_2, $mismatches[1], 1)
            )
            &&
            (
                substr($string_1, $mismatches[1], 1)
                eq
                substr($string_2, $mismatches[0], 1)
            )
        );

    # These must be Buddy Strings
    return(1);

}



