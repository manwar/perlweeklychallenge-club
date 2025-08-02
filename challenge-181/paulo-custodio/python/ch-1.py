#!/usr/bin/env python3

# Challenge 181
#
# Task 1: Sentence Order
# Submitted by: Mohammad S Anwar
#
# You are given a paragraph.
#
# Write a script to order each sentence alphanumerically and print the whole
# paragraph.
# Example
#
# Input:
#     All he could think about was how it would all end. There was
#     still a bit of uncertainty in the equation, but the basics
#     were there for anyone to see. No matter how much he tried to
#     see the positive, it wasn't anywhere to be seen. The end was
#     coming and it wasn't going to be pretty.
#
# Ouput:
#     about All all could end he how it think was would. a anyone
#     basics bit but equation, for in of see still the the There
#     there to uncertainty was were. anywhere be he how it matter
#     much No positive, see seen the to to tried wasn't. and be
#     coming end going it pretty The to was wasn't.

import sys
import textwrap

def read_input():
    text = sys.stdin.read()
    text = ' '.join(text.split())
    return text

def order_sentences(text):
    text = text.rstrip('.')  # remove last period
    sentences = [s.strip() for s in text.split('.')]
    for i in range(len(sentences)):
        sentences[i] = ' '.join(sorted(sentences[i].split(), key=str.lower)) + '.'
    return ' '.join(sentences)

def reflow(text):
    return textwrap.fill(text, width=60)

print(reflow(order_sentences(read_input())))
