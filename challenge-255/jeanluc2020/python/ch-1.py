#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/#TASK1
#
# Task 1: Odd Character
# =====================
#
# You are given two strings, $s and $t. The string $t is generated using the
# shuffled characters of the string $s with an additional character.
#
# Write a script to find the additional character in the string $t..
#
## Example 1
##
## Input: $s = "Perl" $t = "Preel"
## Output: "e"
#
## Example 2
##
## Input: $s = "Weekly" $t = "Weeakly"
## Output: "a"
#
## Example 3
##
## Input: $s = "Box" $t = "Boxy"
## Output: "y"
#
############################################################
##
## discussion
##
############################################################
#
# Split the word into its character, store them in a hash table, then
# count the result for each character in both the table for the original
# word and for the new word.

def odd_character(s: str, t: str) -> None:
    print(f"Input: '{s}', '{t}'")
    s_hash = {}
    t_hash = {}
    for char in list(s):
        if char in s_hash:
            s_hash[char] += 1
        else:
            s_hash[char] = 1
    for char in list(t):
        if char in t_hash:
            t_hash[char] += 1
        else:
            t_hash[char] = 1
    for found in t_hash.keys():
        old = 0
        if found in s_hash:
            old = s_hash[found]
        if t_hash[found] > old:
            print(f"Output: {found}")
            return


odd_character("Perl", "Preel");
odd_character("Weekly", "Weeakly");
odd_character("Box", "Boxy");
