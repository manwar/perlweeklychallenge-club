#!/usr/bin/env python

# Challenge 097
#
# TASK #1 › Caesar Cipher
# Submitted by: Mohammad S Anwar
# You are given string $S containing alphabets A..Z only and a number $N.
#
# Write a script to encrypt the given string $S using Caesar Cipher with left
# shift of size $N.
#
# Example
# Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
# Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
#
# Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
# Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
#
# Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
# Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

import sys

def caeser(n, words):
    output = []
    for word in words:
        codes = [(ord(c)-ord('A')+26-n)%26 for c in word.upper()]
        cipher = [chr(i+ord('A')) for i in codes]
        output.append("".join(cipher))
    return output

n = int(sys.argv[1])
words = sys.argv[2:]
print(" ".join(caeser(n, words)))
