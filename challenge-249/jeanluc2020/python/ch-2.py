#!/usr/bin/env python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/#TASK2
#
# Task 2: DI String Match
# =======================
#
# You are given a string s, consisting of only the characters "D" and "I".
#
# Find a permutation of the integers [0 .. length(s)] such that for each
# character s[i] in the string:
#
# s[i] == 'I' ⇒ perm[i] < perm[i + 1]
# s[i] == 'D' ⇒ perm[i] > perm[i + 1]
#
## Example 1
##
## Input: $str = "IDID"
## Output: (0, 4, 1, 3, 2)
#
## Example 2
##
## Input: $str = "III"
## Output: (0, 1, 2, 3)
#
## Example 3
##
## Input: $str = "DDI"
## Output: (3, 2, 0, 1)
#
############################################################
##
## discussion
##
############################################################
#
# We just count from 0 to length(s) for each "I" and from
# length(s) to 0 for each "D", and in the end add the last
# element we didn't use up yet.

def DI_string_match(string: str) -> list:
    print("Input: '", string, "'", sep="")
    upper = len(string)
    lower = 0
    result = []
    for char in list(string):
        if char == "I":
            result.append(lower)
            lower += 1
        else:
            result.append(upper)
            upper -= 1
    result.append(lower)
    print("Output: (", ", ".join([str(x) for x in result]), ")")
    return result

DI_string_match("IDID");
DI_string_match("III");
DI_string_match("DDI");

