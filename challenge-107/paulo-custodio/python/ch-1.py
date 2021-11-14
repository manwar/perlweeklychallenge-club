#!/usr/bin/env python3

# Challenge 107
#
# TASK #1 - Self-descriptive Numbers
# Submitted by: Mohammad S Anwar
# Write a script to display the first three self-descriptive numbers. As per
# wikipedia, the definition of Self-descriptive Number is
#
# In mathematics, a self-descriptive number is an integer m that in a given
# base b is b digits long in which each digit d at position n (the most
# significant digit being at position 0 and the least significant at position
# b-1) counts how many instances of digit n are in m.
#
# For example:
#
#  1210 is a four-digit self-descriptive number:
#
#     position 0 has value 1 i.e. there is only one 0 in the number
#     position 1 has value 2 i.e. there are two 1 in the number
#     position 2 has value 1 i.e. there is only one 2 in the number
#     position 3 has value 0 i.e. there is no 3 in the number
# Output
#     1210, 2020, 21200

def is_self_descriptive(n):
    for i in range(len(n)):
        count = len(list(filter(lambda x: x==i, n)))
        if n[i]!=count:
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

def self_descriptive(num):
    found = []
    base = 4
    while True:
        n = [0]*base
        n[0] = 1
        while len(n)==base:
            if is_self_descriptive(n):
                found.append("".join([str(x) for x in n]))
                if len(found) >= num:
                    return found
            increment(n, base)
        base += 1

self_descr = self_descriptive(3)
print(", ".join(self_descr))
