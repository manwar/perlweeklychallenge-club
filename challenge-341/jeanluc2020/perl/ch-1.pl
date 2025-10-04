#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/#TASK1
#
# Task 1: Broken Keyboard
# =======================
#
# You are given a string containing English letters only and also you are given
# broken keys.
#
# Write a script to return the total words in the given sentence can be typed
# completely.
#
## Example 1
##
## Input: $str = 'Hello World', @keys = ('d')
## Output: 1
##
## With broken key 'd', we can only type the word 'Hello'.
#
#
## Example 2
##
## Input: $str = 'apple banana cherry', @keys = ('a', 'e')
## Output: 0
#
#
## Example 3
##
## Input: $str = 'Coding is fun', @keys = ()
## Output: 3
##
## No keys broken.
#
#
## Example 4
##
## Input: $str = 'The Weekly Challenge', @keys = ('a','b')
## Output: 2
#
#
## Example 5
##
## Input: $str = 'Perl and Python', @keys = ('p')
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# Create a list of the words in $str. Then for each of the words,
# check if any of the characters in the word is a broken key, we remove
# it from the list. Count the remaining words as the result

use v5.36;


broken_keyboard('Hello World', 'd');
broken_keyboard('apple banana cherry', 'a', 'e');
broken_keyboard('Coding is fun' );
broken_keyboard('The Weekly Challenge', 'a','b');
broken_keyboard('Perl and Python', 'p');

sub broken_keyboard($str, @keys) {
    say "Input: '$str', (" . join(", ", @keys) . ")";
    my @words = split /\s+/, $str;
    my $count = scalar(@words);
    OUTER:
    foreach my $w (@words) {
        foreach my $key (@keys) {
            if($w =~ m/$key/i) {
                $count--;
                next OUTER;
            }
        }
    }
    say "Output: $count";
}
