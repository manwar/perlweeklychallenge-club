#!/usr/bin/python3

# Challenge 022
#
# Task #2
# Write a script to implement Lempel-Ziv-Welch (LZW) compression algorithm.
# The script should have method to encode/decode algorithm. The wiki page
# explains the compression algorithm very nicely.

import sys

class Dict():
    EOM = '#'
    SYMBOLS = ['A','B','C','D','E','F','G','H','I','J','K','L','M',
               'N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

    def __init__(self):
        self.dict = {}
        self.symbols = []
        for sym in [Dict.EOM, *Dict.SYMBOLS]:
            self.add(sym)

    def __str__(self):
        return "dict="+str(self.dict)+",symbols="+str(self.symbols)

    def last(self):
        return len(self.symbols)-1

    def width(self):
        return len("{:b}".format(self.last()))

    def next_width(self):
        return len("{:b}".format(self.last()+1))

    def add(self, seq):
        seq = seq.upper()

        id = self.last()+1
        self.dict[seq] = id
        self.symbols.append(seq)

    def longest_match(self, text):
        text = text.upper()

        # find longest match
        match_len = 0
        while match_len < len(text) and \
              text[:match_len+1] in self.dict:
            match_len += 1
        w = text[:match_len]
        text = text[match_len:]
        code = self.dict[w]
        old_width = self.width()

        # store new prefix in the dictionary
        if text != "":
            next_prefix = w+text[0]
            self.add(next_prefix)

        # return code and new text
        return ("{:0"+str(old_width)+"b}").format(code), text

def encode(text):
    text = text.upper()+Dict.EOM
    encoded = ""
    dict = Dict()

    while text != "":
        code, text = dict.longest_match(text)
        encoded += code

    return encoded

def decode(encoded):
    text = ""
    dict = Dict()

    while encoded != "":
        width = dict.width()
        code = int(encoded[:width], 2)
        encoded = encoded[width:]
        seq = dict.symbols[code]
        text += seq

        if encoded != "":
            next_width = dict.next_width()
            next_code = int(encoded[:next_width], 2)
            next_seq = dict.symbols[next_code]
            dict.add(seq + next_seq[0])

    # remove end terminator
    text = text[:-1]
    return text

if sys.argv[1] == "encode":
    print(encode(sys.argv[2]))
elif sys.argv[1] == "decode":
    print(decode(sys.argv[2]))
else:
    print("Usage: ch-2.py encode|decode text")
