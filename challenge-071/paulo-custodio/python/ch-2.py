#!/usr/bin/env python3

# Challenge 071
#
# TASK #2 > Trim Linked List
# Submitted by: Mohammad S Anwar
# You are given a singly linked list and a positive integer $N (>0).
#
# Write a script to remove the $Nth node from the end of the linked list and
# print the linked list.
#
# If $N is greater than the size of the linked list then remove the first
# node of the list.
#
# NOTE: Please use pure linked list implementation.
#
# Example
# Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
# when $N = 1
# Output: 1 -> 2 -> 3 -> 4
# when $N = 2
# Output: 1 -> 2 -> 3 -> 5
# when $N = 3
# Output: 1 -> 2 -> 4 -> 5
# when $N = 4
# Output: 1 -> 3 -> 4 -> 5
# when $N = 5
# Output: 2 -> 3 -> 4 -> 5
# when $N = 6
# Output: 2 -> 3 -> 4 -> 5

import sys

def list_len(lst):
    length = 0
    while lst:
        length += 1
        lst = lst[1]
    return length

def remove_n(remove, lst):
    if remove == 0:
        return lst[1]
    else:
        p = lst
        last = None
        while p:
            if remove == 0:
                last[1] = p[1]
            last = p
            p = p[1]
            remove -= 1
        return lst

def show(lst):
    out = []
    while lst:
        out.append(lst[0])
        lst = lst[1]
    print(" ".join(map(str, out)))

n = int(sys.argv[1]) if len(sys.argv) > 1 else 1
lst = None
for arg in reversed(sys.argv[2:]):
    lst = [arg, lst]

length = list_len(lst)
remove = 0 if n > length else length - n
lst = remove_n(remove, lst)
show(lst)
