#!/opt/homebrew/bin/python3

import sys

#
# Return true if both strings are anagrams of each other. 
# We do this by turning the stings into lists of characters
# (using "list"), then sorting them (using "sorted"), and
# then joining them using an empty string. Finally, we compare
# the resulting strings.
#
def are_anagrams (str1, str2):
    s_str1 = "" . join (sorted (list (str1)))
    s_str2 = "" . join (sorted (list (str2)))
    return s_str1 == s_str2

#
# Return true if we can scramble the input into the target.
# We consider the following cases:
#    - If both string are equal, we can
#    - If the strings are not of equal length, we cannot
#    - If the strings don't contain the same letters, we cannot
#    - Otherwise, we try all ways of splitting the strings into
#          non-zero length, and see whether we can scramble both
#          halves into each other, possibly after swapping
#
def can_scramble (input, target):
    if input == target:                  return True
    if len (input) != len (target):      return False
    if not are_anagrams (input, target): return False

    for l in range (1, len (input)):
        m = len (input) - l
        if can_scramble (input [0: l], target [0: l]) and \
           can_scramble (input [l:],   target [l:])    or \
           can_scramble (input [l:],   target [0: m]) and \
           can_scramble (input [0: l], target [m:]):
            return True


for line in sys . stdin:
    [input, target] = line . split ()
    print ("true" if can_scramble (input, target) else "false")
