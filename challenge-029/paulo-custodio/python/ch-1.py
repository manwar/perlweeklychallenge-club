#!/usr/bin/python3

# Challenge 029

# Task #1
# Write a script to demonstrate brace expansion. For example, script would take
# command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and should
# expand it and print like below:
#
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

import sys
import re

def print_expanded(text):
    mo = re.search(r"[{]([^{}]*?)[}]", text)
    if mo:
        before = text[:mo.start(0)]
        expand = mo.group(1)
        after  = text[mo.end(0):]

        for arg in expand.split(","):
            print_expanded(before+arg+after)
    else:
        print(text)

print_expanded(" ".join(sys.argv[1:]))
