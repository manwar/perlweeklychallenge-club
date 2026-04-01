#!/usr/bin/env python3

# Perl Weekly Challenge 181 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-181/

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
