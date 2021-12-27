#!/usr/bin/env python3

# Challenge 131
#
# TASK #2 > Find Pairs
# Submitted by: Yary
# You are given a string of delimiter pairs and a string to search.
#
# Write a script to return two strings, the first with any characters
# matching the "opening character" set, the second with any matching
# the "closing character" set.
#
# Example 1:
# Input:
#     Delimiter pairs: ""[]()
#     Search String: "I like (parens) and the Apple ][+" they said.
#
# Output:
#     "(["
#     ")]"
# Example 2:
# Input:
#     Delimiter pairs: **//<>
#     Search String: /* This is a comment (in some languages) */ <could be a tag>
#
# Output:
#     /**/<
#     /**/>

delims = input()
string = input()

open_delims  = delims[0::2]
close_delims = delims[1::2]

open_string  = ""
close_string = ""
for c in string:
    if c in open_delims:
        open_string  += c
    if c in close_delims:
        close_string += c

print(open_string)
print(close_string)
