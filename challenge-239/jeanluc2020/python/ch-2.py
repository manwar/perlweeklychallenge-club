#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/#TASK2
#
# Task 2: Consistent Strings
# ==========================
#
# You are given an array of strings and allowed string having distinct
# characters.
#
## A string is consistent if all characters in the string appear in the string
## allowed.
#
# Write a script to return the number of consistent strings in the given array.
#
## Example 1
##
## Input: @str = ("ad", "bd", "aaab", "baa", "badab")
##        $allowed = "ab"
## Output: 2
##
## Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
#
## Example 2
##
## Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
##        $allowed = "abc"
## Output: 7
#
## Example 3
##
## Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
##        $allowed = "cad"
## Output: 4
##
## Strings "cc", "acd", "ac", and "d" are consistent.
#
############################################################
##
## discussion
##
############################################################
#
# Create a dict that uses the characters of allowed as
# the keys. Then for each string in the array, check all the
# characters. If one of those isn't in the hash table, the
# string is not consistent, so we don't count the string.
# Otherwise, count the string as consistent.
#

def consistent_strings(arr: list, allowed: str):
    print("Input: @str = (\"", "\", \"".join(arr), "\"), $allowed = \"", allowed, "\"", sep='')
    allowed_chars = {}
    for char in [*allowed]:
        allowed_chars[char] = 1
    count = 0
    for string in arr:
        consistent = 1
        for char in [*string]:
            if char not in allowed_chars:
                consistent = 0
                break
        if consistent:
            count += 1
    print(f"Output: {count}")


consistent_strings( ["ad", "bd", "aaab", "baa", "badab"], "ab")
consistent_strings( ["a", "b", "c", "ab", "ac", "bc", "abc"], "abc")
consistent_strings( ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad")

