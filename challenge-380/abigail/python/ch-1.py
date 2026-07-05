#!/opt/homebrew/bin/python3

import sys, re

for line in sys . stdin:
    chars = {}
    for ch in line:
        if "a" <= ch and ch <= "z":
            chars [ch] = chars . get (ch, 0) + 1
    max = {"c": 0, "v": 0}
    for ch in chars . keys ():
        index = "v" if re . match ("[aeiou]", ch) else "c"
        if  max [index] < chars [ch]:
            max [index] = chars [ch]
    print (max ["c"] + max ["v"])
