#!/usr/bin/env python3

# TASK #2 > Add Linked Lists
# Submitted by: Mohammad S Anwar
# You are given two linked list having single digit positive numbers.
#
# Write a script to add the two linked list and create a new linked representing
# the sum of the two linked list numbers. The two linked lists may or may not
# have the same number of elements.
#
# HINT: Just a suggestion, feel free to come up with your own unique way to deal
# with the task. I am expecting a class representing linked list. It should have
# methods to create a linked list given list of single digit positive numbers
# and a method to add new member. Also have a method that takes 2 linked list
# objects and returns a new linked list. Finally a method to print the linked
# list object in a user friendly format.
#
# Example 1:
# Input: L1 = 1 -> 2 -> 3
#        L2 = 3 -> 2 -> 1
# Output: 4 -> 4 -> 4
#
# Example 2:
# Input: L1 = 1 -> 2 -> 3 -> 4 -> 5
#        L2 =           6 -> 5 -> 5
# Output:     1 -> 3 -> 0 -> 0 -> 0

import sys

def node(head, tail):
    return [head, tail]

def drop(strm):
    if strm is None:
        return None, strm
    else:
        head = strm[0]
        tail = strm[1]
        return head, tail

def show_strm(strm):
    if strm is None:
        return ""
    else:
        n, strm = drop(strm)
        return str(n) + " " + show_strm(strm)

def list_to_stream(lst):
    stream = None
    while len(lst) > 0:
        stream = node(lst.pop(), stream)
    return stream

def reverse_stream(in_strm):
    out_strm = None
    while in_strm:
        n, in_strm = drop(in_strm)
        out_strm = node(n, out_strm)
    return out_strm

def add_streams(s1, s2):
    s1 = reverse_stream(s1)
    s2 = reverse_stream(s2)
    result = None
    carry = 0
    while s1 or s2 or carry!=0:
        n1, s1 = drop(s1)
        if not n1:
            n1 = 0
        n2, s2 = drop(s2)
        if not n2:
            n2 = 0
        s = n1+n2+carry
        result = node(s % 10, result)
        carry = int(s / 10)
    return result

l1 = list_to_stream([int(x) for x in sys.argv[1]])
l2 = list_to_stream([int(x) for x in sys.argv[2]])
s = add_streams(l1, l2)
print(show_strm(s))
