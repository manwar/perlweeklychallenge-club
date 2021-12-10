#!/usr/bin/python3

# Challenge 026
#
# Task #1
# Create a script that accepts two strings, let us call it, "stones" and
# "jewels". It should print the count of "alphabet" from the string "stones"
# found in the string "jewels". For example, if your stones is "chancellor" and
# "jewels" is "chocolate", then the script should print "8". To keep it simple,
# only A-Z,a-z characters are acceptable. Also make the comparison case
# sensitive.

import sys

def count(letters, word):
    letters = set([x for x in letters])
    return len(list(filter(lambda x: x in letters, [x for x in word])))

print(count(sys.argv[1], sys.argv[2]))
