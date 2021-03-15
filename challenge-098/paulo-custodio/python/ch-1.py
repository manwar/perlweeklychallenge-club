#!/usr/bin/env python

# Challenge 098
#
# TASK #1 > Read N-characters
# Submitted by: Mohammad S Anwar
# You are given file $FILE.
#
# Create subroutine readN($FILE, $number) returns the first n-characters and
# moves the pointer to the (n+1)th character.
#
# Example:
# Input: Suppose the file (input.txt) contains "1234567890"
# Output:
#     print readN("input.txt", 4); # returns "1234"
#     print readN("input.txt", 4); # returns "5678"
#     print readN("input.txt", 4); # returns "90"

import sys

files = {}

def readN(filename, n):
    if not filename in files:
        files[filename] = open(filename, "r")
    return files[filename].read(n)

for i in range(1, len(sys.argv)-1, 2):
    print(readN(sys.argv[i], int(sys.argv[i+1])))
