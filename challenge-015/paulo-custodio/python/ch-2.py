#!/usr/bin/python3

# Challenge 015
#
# Task #2
# Write a script to implement Vigenere cipher. The script should be able encode
# and decode. Checkout wiki page for more information.

import sys

def text_codes(text):
    codes = []
    for c in text.upper():
        if c.isalpha():
            codes.append(ord(c)-ord('A'))
    return codes

def codes_text(codes):
    return "".join([chr(ord('A')+x) for x in codes])

def vigenere(plain, key, encode):
    plain = text_codes(plain)
    key = text_codes(key)
    ikey = 0
    cipher = []
    for c in plain:
        if encode:
            cipher.append((c + key[ikey])%26)
        else:
            cipher.append((c - key[ikey] + 26)%26)
        ikey = (ikey+1) % len(key)
    return codes_text(cipher)

encode = True if sys.argv[1]=="encode" else False
key = sys.argv[2]
text = " ".join(sys.argv[3:])

print(vigenere(text, key, encode))
