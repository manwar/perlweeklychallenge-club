#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/#TASK1
#
# Task 1: Split Strings
# =====================
#
# You are given an array of strings and a character separator.
#
# Write a script to return all words separated by the given character excluding
# empty string.
#
# Example 1
#
# Input: @words = ("one.two.three","four.five","six")
#        $separator = "."
# Output: "one","two","three","four","five","six"
#
# Example 2
#
# Input: @words = ("$perl$$", "$$raku$")
#        $separator = "$"
# Output: "perl","raku"
#
############################################################
##
## discussion
##
############################################################
#
# This is a classic one-liner problem: join the words into a single string,
# then split this string into an array of strings at the separator, then
# only keep the non-empty strings by grepping for strings that contain one
# character.
#

import re

def split_strings(separator: str, words: list) -> None:
    print("Input: (\"", "\", \"".join(words), "\"), '", separator, "'",  sep="")
    output = []
    for value in separator.join(words).split(separator):
        if len(value) > 0:
            output.append(value)
    print("Output: (\"", "\", \"".join(output), "\")", sep="")


split_strings(".", ["one.two.three","four.five","six"])
split_strings('$', ['$perl$$', '$$raku$'])

