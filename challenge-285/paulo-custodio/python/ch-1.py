#!/usr/bin/env python3

# Challenge 285
#
# Task 1: No Connection
# Submitted by: Mohammad Sajid Anwar
#
# You are given a list of routes, @routes.
#
# Write a script to find the destination with no further outgoing connection.
# Example 1
#
# Input: @routes = (["B","C"], ["D","B"], ["C","A"])
# Output: "A"
#
# "D" -> "B" -> "C" -> "A".
# "B" -> "C" -> "A".
# "C" -> "A".
# "A".
#
# Example 2
#
# Input: @routes = (["A","Z"])
# Output: "Z"

import sys

def endpoints(routes):
    endp = {}
    for p in routes:
        if not p[1] in endp:
            endp[p[1]] = 1
    for p in routes:
        if p[0] in endp:
            del endp[p[0]]
    return sorted(list(endp.keys()))

pairs = (" ".join(sys.argv[1:])).split(",")
routes = [x.split() for x in pairs]
print(", ".join(endpoints(routes)))
