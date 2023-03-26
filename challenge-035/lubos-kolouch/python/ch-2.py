#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import unittest

# Define Morse code mappings
morse_code = {
    ".-": "A",
    "-...": "B",
    "-.-.": "C",
    "-..": "D",
    ".": "E",
    "..-.": "F",
    "--.": "G",
    "....": "H",
    "..": "I",
    ".---": "J",
    "-.-": "K",
    ".-..": "L",
    "--": "M",
    "-.": "N",
    "---": "O",
    ".--.": "P",
    "--.-": "Q",
    ".-.": "R",
    "...": "S",
    "-": "T",
    "..-": "U",
    "...-": "V",
    ".--": "W",
    "-..-": "X",
    "-.--": "Y",
    "--..": "Z",
    "/": " ",
}


# Decode binary encoded Morse code
def decode_morse(encoded):
    # Split encoded text into words and characters
    words = re.findall("0{7}", encoded + "0000000")
    letters = [re.findall("0{3}", word + "000") for word in words]
    # Convert Morse code to plaintext
    plaintext = ""
    for word in letters:
        for letter in word:
            if letter in morse_code:
                plaintext += morse_code[letter]
            else:
                # If the Morse code is badly formed, try to recover by looking one digit ahead
                for i in range(1, 4):
                    lookahead = letter[i:]
                    if lookahead in morse_code:
                        plaintext += morse_code[lookahead]
                        break
                else:
                    # If no valid Morse code sequence can be recovered, treat the character as a space
                    plaintext += " "
    return plaintext
