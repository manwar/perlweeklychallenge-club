#!/usr/bin/env python3

# Challenge 043
#
# TASK #2
# Self-descriptive Numbers
# Contributed by Laurent Rosenfeld
# Write a script to generate Self-descriptive Numbers in a given base.
#
# In mathematics, a self-descriptive number is an integer m that in a given base
# b is b digits long in which each digit d at position n (the most significant
# digit being at position 0 and the least significant at position b - 1) counts
# how many instances of digit n are in m.
#
# For example, if the given base is 10, then script should print 6210001000. For
# more information, please checkout wiki page.

import sys

def is_self_descriptive(n):
    for i in range(len(n)):
        same = list(filter(lambda x: x==i, n))
        if n[i] != len(same):
            return False
    return True

def increment(n, base):
    i = len(n)-1
    while i >= 0:
        n[i] += 1
        if n[i] < base:
            return
        else:
            n[i] = 0
            i -= 1
    n.insert(0, 1)

def print_self_descriptive(base):
    n = [0 for x in range(base)]
    n[0] = 1
    while len(n) == base:
        if is_self_descriptive(n):
            print("".join([str(x) for x in n]))
            return
        increment(n, base)

print_self_descriptive(int(sys.argv[1]))
