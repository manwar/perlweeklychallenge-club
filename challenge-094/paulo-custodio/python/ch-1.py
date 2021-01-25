#!/usr/bin/env python

# Challenge 094
#
# TASK #1 > Group Anagrams
# Submitted by: Mohammad S Anwar
# You are given an array of strings @S.
#
# Write a script to group Anagrams together in any random order.
#
# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
#
# Example 1:
#     Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
#     Output: [ ("bat", "tab"),
#               ("saw", "was"),
#               ("top", "pot", "opt") ]
# Example 2:
#     Input: ("x")
#     Output: [ ("x") ]

import sys

def make_key(str):
    return ''.join(sorted(str))

def print_map(map):
    output = "[ "
    for value in map.values():
        output += "("
        for word in value:
            output += '"' + word + '", '
        output = output[:-2] + "),\n  "
    output = output[:-4] + " ]"
    print(output)

def solve():
    map = {}

    for arg in sys.argv[1:]:
        key = make_key(arg)
        if key not in map:
            map[key] = []
        map[key] += [arg]

    print_map(map)

solve()
