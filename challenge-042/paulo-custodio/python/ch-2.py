#!/usr/bin/env python3

# Challenge 042
#
# TASK #2
# Balanced Brackets
# Write a script to generate a string with random number of ( and ) brackets.
# Then make the script validate the string if it has balanced brackets.
#
# For example:
#
# () - OK
# (()) - OK
# )( - NOT OK
# ())() - NOT OK

import fileinput
import re

for line in fileinput.input():
    str = line.rstrip()
    print(f"{str} - ", end="")
    while True:
        str, n = re.subn(r"\(\)", "", str)
        if n==0:
            break
    if str=="":
        print("OK")
    else:
        print("NOT OK")
