#!/usr/bin/python3

# Challenge 145
#
# TASK #2 > Palindromic Tree
# Submitted by: Mohammad S Anwar
# You are given a string $s.
#
# Write a script to create a Palindromic Tree for the given string.
#
# I found this blog exaplaining Palindromic Tree in detail.
#
# Example 1:
# Input: $s = 'redivider'
# Output: r redivider e edivide d divid i ivi v
# Example 2:
# Input: $s = 'deific'
# Output: d e i ifi f c
# Example 3:
# Input: $s = 'rotors'
# Output: r rotor o oto t s
# Example 4:
# Input: $s = 'challenge'
# Output: c h a l ll e n g
# Example 5:
# Input: $s = 'champion'
# Output: c h a m p i o n
# Example 6:
# Input: $s = 'christmas'
# Output: c h r i s t m a

import sys

# https://rosettacode.org/wiki/Eertree#Perl
def build_eertree(text):
    pal = []
    for n in range(1, len(text)+1):
        for m in range(1, len(text)-(n-1)+1):
            strpal = text[n-1:n-1+m]
            if strpal==strpal[::-1]:
                pal.append(strpal)

    seen = set()
    for strpal in pal:
        if strpal not in seen:
            print(strpal, end=" ")
            seen.add(strpal)
    print("")

build_eertree(sys.argv[1])
