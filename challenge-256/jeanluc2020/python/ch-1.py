#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/#TASK1
#
# Task 1: Maximum Pairs
# =====================
#
# You are given an array of distinct words, @words.
#
# Write a script to find the maximum pairs in the given array. The words
# $words[i] and $words[j] can be a pair one is reverse of the other.
#
## Example 1
##
## Input: @words = ("ab", "de", "ed", "bc")
## Output: 1
##
## There is one pair in the given array: "de" and "ed"
#
## Example 2
##
## Input: @words = ("aa", "ba", "cd", "ed")
## Output: 0
#
## Example 3
##
## Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# Just check all possible pairs.

def reverse_word(word: str) -> str:
    chars = list(word)
    return "".join(reversed(chars))

def maximum_pairs(words: list) -> None:
    print("Input: (\"", "\", \"".join(words), "\")", sep="")
    count = 0
    for i in range(len(words)):
        for j in range(i+1, len(words)):
            if words[i] == reverse_word(words[j]):
                count += 1
                break
    print(f"Output: {count}")

maximum_pairs(["ab", "de", "ed", "bc"]);
maximum_pairs(["aa", "ba", "cd", "ed"]);
maximum_pairs(["uv", "qp", "st", "vu", "mn", "pq"]);

