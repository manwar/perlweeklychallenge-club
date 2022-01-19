#!/usr/bin/python3

# Challenge 035
#
# TASK #1
# Contributed by Paul Johnson
# Write a program to encode text into binary encoded morse code.
# Pay attention to any changes which might need to be made to the text to
# make it valid morse code.
#
# Morse code consists of dots, dashes and gaps. It can be encoded in binary
# in the following fashion:
#
# dot: 1
# dash: 111
# intra-character gap: 0
# character gap: 000
# word gap: 0000000
# An intra-character gap is inserted between the dots and dashes in a character.

import sys
import re

# morse code chart
MORSE = { 'A':'.-',    'B':'-...',  'C':'-.-.',  'D':'-..',   'E':'.',
          'F':'..-.',  'G':'--.',   'H':'....',  'I':'..',    'J':'.---',
          'K':'-.-',   'L':'.-..',  'M':'--',    'N':'-.',    'O':'---',
          'P':'.--.',  'Q':'--.-',  'R':'.-.',   'S':'...',   'T':'-',
          'U':'..-',   'V':'...-',  'W':'.--',   'X':'-..-',  'Y':'-.--',
          'Z':'--..',  '1':'.----', '2':'..---', '3':'...--', '4':'....-',
          '5':'.....', '6':'-....', '7':'--...', '8':'---..', '9':'----.',
          '0':'-----'}

def encode_bin_morse(text):
    encoded = ""
    for c in text.upper():
        if c.isalnum():
            morse = MORSE[c]
            morse = re.sub(r"\.", "10", morse)
            morse = re.sub(r"\-", "1110", morse)
            encoded += morse+"00"
        else:
            encoded += "0000"
    encoded = re.sub(r"0+$", "", encoded)
    return encoded

print(encode_bin_morse(" ".join(sys.argv[1:])))
