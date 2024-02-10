#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/#TASK2
#
# Task 2: Most Frequent Word
# ==========================
#
# You are given a paragraph $p and a banned word $w.
#
# Write a script to return the most frequent word that is not banned.
#
## Example 1
##
## Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
##        $w = "hit"
## Output: "ball"
##
## The banned word "hit" occurs 3 times.
## The other word "ball" occurs 2 times.
#
## Example 2
##
## Input: $p = "Perl and Raku belong to the same family. Perl is the most
## popular language in the weekly challenge."
##        $w = "the"
## Output: "Perl"
##
## The banned word "the" occurs 3 times.
## The other word "Perl" occurs 2 times.
#
############################################################
##
## discussion
##
############################################################
#
# Split the sentence into its words, then count all the words != $w

import re
from operator import itemgetter

def most_frequent_word(p: str, w: str) -> None:
    print(f"Input: '{p}', '{w}'")
    found = {}
    for word in re.split('\W+', p):
        if word != w:
            if word in found:
                found[word] += 1
            else:
                found[word] = 1
    most = []
    for key in found.keys():
        most.append( (key, found[key]) )
    most.sort(key=itemgetter(1))
    print(most)
    print(f"Found the most frequent word to be '{most[-1][0]}'")

most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit.", "hit");
most_frequent_word("Perl and Raku belong to the same family. Perl is the most" +
   " popular language in the weekly challenge.", "the");

