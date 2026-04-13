#!/opt/homebrew/bin/python3

import sys
import re

def tolower (match):
    return match . group (1) . upper ()

for input in sys . stdin:
    input = re . sub (r'^\s+',         "",      input) # Remove leading spaces
    input = re . sub (r'[^\sa-zA-Z]+', "",      input) # Remove non-letter,
                                                       # non space characters
    input = re . sub (r'\s+$',         "",      input) # Remove trailing spaces
    input = input . lower ()                           # Lower case string
    input = re . sub (r'\s+([a-z])',   tolower, input) # Upper case each letter
                                                       # following white space,
                                                       # removing the space
    input = "#" + input                                # Add leading hash

    print (input [:100])                               # Print at most 100 chars
