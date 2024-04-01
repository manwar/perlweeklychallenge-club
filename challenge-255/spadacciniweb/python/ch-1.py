# Task 1: Odd Character
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings, $s and $t. The string $t is generated using the shuffled characters of the string $s with an additional character.
# Write a script to find the additional character in the string $t..
# 
# Example 1
# Input: $s = "Perl" $t = "Preel"
# Output: "e"
# 
# Example 2
# Input: $s = "Weekly" $t = "Weeakly"
# Output: "a"
# 
# Example 3
# Input: $s = "Box" $t = "Boxy"
# Output: "y"

from collections import Counter

def odd_character(s, t):
    counts=Counter(s)

    for i in t:
        counts[i] -= 1
    print("Output:", s, "|", t, "-> %s" %(list(counts.keys())[list(counts.values()).index(-1)]))

if __name__ == "__main__":
    s = 'Perl'
    t = "Preel"
    odd_character(s, t)

    s = "Weekly"
    t = "Weeakly"
    odd_character(s, t)

    s = "Box"
    t = "Boxy"
    odd_character(s, t)
