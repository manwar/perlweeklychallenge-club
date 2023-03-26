#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest

# Define Morse code mappings
morse_code = {
    "A": ".-",
    "B": "-...",
    "C": "-.-.",
    "D": "-..",
    "E": ".",
    "F": "..-.",
    "G": "--.",
    "H": "....",
    "I": "..",
    "J": ".---",
    "K": "-.-",
    "L": ".-..",
    "M": "--",
    "N": "-.",
    "O": "---",
    "P": ".--.",
    "Q": "--.-",
    "R": ".-.",
    "S": "...",
    "T": "-",
    "U": "..-",
    "V": "...-",
    "W": ".--",
    "X": "-..-",
    "Y": "-.--",
    "Z": "--..",
    " ": "/",
}


# Encode text into binary encoded Morse code
def encode_morse(text):
    encoded = ""
    for char in text.upper():
        if char in morse_code:
            morse = morse_code[char]
            bits = []
            for symbol in morse:
                if symbol == ".":
                    bits.extend(["1", "0"])
                elif symbol == "-":
                    bits.extend(["1" * 3, "0"])
            encoded += "0".join(bits) + "0"
    encoded = encoded.rstrip("0")  # Remove trailing intra-character gap
    return encoded


# Define tests
class TestMorseEncoding(unittest.TestCase):
    def test_hello_world(self):
        encoded_text = encode_morse("HELLO WORLD")
        self.assertEqual(
            encoded_text,
            "1010100011101110111010111000101110100010111010001110101000101011100010111010001110100011101011100010101110001011101000101110100010111010001110100011101011100010111010001110100011101011100010101110001011101",
        )
