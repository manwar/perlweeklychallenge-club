#!/usr/bin/env python3

# Perl Weekly Challenge 287 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/

import re
import sys

def is_strong(password):
    if len(password) < 6:
        return False
    elif not re.search(r'[a-z]', password):
        return False
    elif not re.search(r'[A-Z]', password):
        return False
    elif not re.search(r'[0-9]', password):
        return False
    elif re.search(r'(.)\1\1+', password):
        return False
    else:
        return True

def charset(a, b):
    return "".join([chr(x) for x in range(ord(a), ord(b)+1)])

def next_char(password):
    avail_chars = ""
    if not re.search(r'[a-z]', password):
        avail_chars += charset('a', 'z')
    if not re.search(r'[A-Z]', password):
        avail_chars += charset('A', 'Z')
    if not re.search(r'[0-9]', password):
        avail_chars += charset('0', '9')
    avail_chars += charset('a', 'z')
    avail_chars += charset('A', 'Z')
    avail_chars += charset('0', '9')

    for ch in password:
        avail_chars, _ = re.subn(ch, '', avail_chars)

    return avail_chars[0]

def steps_to_strong(password):
    steps = 0
    while not is_strong(password):
        if re.search(r'(.)\1\1+', password):
            password = re.sub(r'(.)\1\1', r'\1\1'+next_char(password)+'\1', password)
        else:
            password += next_char(password)
        steps += 1
    return steps

print(steps_to_strong(sys.argv[1]))
