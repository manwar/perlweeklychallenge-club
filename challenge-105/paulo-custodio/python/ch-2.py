#!/usr/bin/env python3

# Challenge 105
#
# TASK #2 > The Name Game
# Submitted by: Mohammad S Anwar
# You are given a $name.
#
# Write a script to display the lyrics to the Shirley Ellis song The Name Game.
# Please checkout the wiki page for more information.
#
# Example
# Input: $name = "Katie"
# Output:
#
#     Katie, Katie, bo-batie,
#     Bonana-fanna fo-fatie
#     Fee fi mo-matie
#     Katie!

import sys
import re

name = sys.argv[1]
end = re.sub(r"^[bcdfghjklmnpqrstvwxyz]", "", name, flags=re.IGNORECASE).lower()

if re.search(r"^b", name, flags=re.IGNORECASE):
    b = ""
else:
    b = "b"

if re.search(r"^f", name, flags=re.IGNORECASE):
    f = ""
else:
    f = "f"

if re.search(r"^m", name, flags=re.IGNORECASE):
    m = ""
else:
    m = "m"

print(f"{name}, {name}, bo-{b}{end},")
print(f"Bonana-fanna fo-{f}{end}")
print(f"Fee fi mo-{m}{end}")
print(f"{name}!")
