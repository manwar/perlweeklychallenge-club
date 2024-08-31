#!/usr/bin/env python3

# Challenge 045
#
# TASK #1
# Square Secret Code
#
# The square secret code mechanism first removes any space from the original
# message. Then it lays down the message in a row of 8 columns. The coded
# message is then obtained by reading down the columns going left to right.
#
# For example, the message is "The quick brown fox jumps over the lazy dog".
#
# Then the message would be laid out as below:
#
# thequick
# brownfox
# jumpsove
# rthelazy
# dog
#
# The code message would be as below:
#
# tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#
# Write a script that accepts a message from command line and prints the
# equivalent coded message.

import re
import sys

def encode(text):
    text, dummy = re.subn(r'\W+', '', text)
    box = []
    while text != '':
        box.append(text[0:8])
        text = text[8:]
    encoded = []
    while True:
        box = [x for x in filter(lambda x: x != '', box)]
        if len(box) == 0:
            break;
        word = ""
        for i in range(len(box)):
            if len(box[i]) > 0:
                word += box[i][0]
                box[i] = box[i][1:]
        encoded.append(word)
    return encoded

print(' '.join(encode(''.join(sys.argv[1:]))))
