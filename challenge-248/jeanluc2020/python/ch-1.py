#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/#TASK1
#
# Task 1: Shortest Distance
# =========================
#
# You are given a string and a character in the given string.
#
# Write a script to return an array of integers of size same as length of the
# given string such that:
#
# distance[i] is the distance from index i to the closest occurence of
# the given character in the given string.
#
# The distance between two indices i and j is abs(i - j).
#
## Example 1
##
## Input: $str = "loveleetcode", $char = "e"
## Output: (3,2,1,0,1,0,0,1,2,2,1,0)
##
## The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
## The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(0 - 3) = 3.
## The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(1 - 3) = 2.
## For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
## but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
## The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(8 - 6) = 2.
#
## Example 2
##
## Input: $str = "aaab", $char = "b"
## Output: (3,2,1,0)
#
############################################################
##
## discussion
##
############################################################
#
# Let's split the input string into its characters and fill an
# array from that. Then we create a map using the positions of
# all occurrences of the wanted character. Now we walk the array
# and take the minimum of all possible differences found to
# elements from the map, or -1 if the map is empty (this is
# just extra error handling in case someone throws a character
# into the function that doesn't exist in the string, we just
# return -1 for all characters in that case).

def shortest_distance(string: str, char: str) -> list:
    print(f"Input: '{string}', '{char}'")
    str_chars = list(string)
    map = []
    for i in range(len(str_chars)):
        if str_chars[i] == char:
            map.append(i)
    result = []
    for i in range(len(str_chars)):
        result.append(min([abs(i-x) for x in map], default = -1))
    print(f"Output: (", ",".join(str(x) for x in result), ")")
    return result


shortest_distance("loveleetcode", "e")
shortest_distance("aaab", "b")
shortest_distance("aaab", "c")

