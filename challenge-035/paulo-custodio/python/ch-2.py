#!/usr/bin/python3

# Challenge 035
#
# Challenge 035
#
# TASK #2
# Contributed by Paul Johnson
# Write a program to decode binary morse code.
# Consider how it might be possible to recover from badly formed morse code.
#
# a) by splitting the morse code on gaps
# b) without looking further than one digit ahead

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

MORSE_INV = {v:k for k, v in MORSE.items()}

def decode_bin_morse(encoded):
    encoded = re.sub(r"0+$", "", encoded)           # remove trailing 0s
    encoded = re.sub(r"0000000", "\n", encoded)     # word gap
    encoded = re.sub(r"000", " ", encoded)          # character gap
    encoded = re.sub(r"1110?", "-", encoded)        # -
    encoded = re.sub(r"10?", ".", encoded)          # .

    text = ""
    words = encoded.split("\n")
    for word in words:
        chars = word.split()
        for c in chars:
            text += MORSE_INV[c]
        text += " "
    text = re.sub(r"\s+$", "", text)
    return text

print(decode_bin_morse(" ".join(sys.argv[1:])))
