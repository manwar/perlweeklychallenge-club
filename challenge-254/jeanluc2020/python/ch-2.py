#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/#TASK2
#
# Task 2: Reverse Vowels
# ======================
#
# You are given a string, $s.
#
# Write a script to reverse all the vowels (a, e, i, o, u) in the given string.
#
## Example 1
##
## Input: $s = "Raku"
## Output: "Ruka"
#
## Example 2
##
## Input: $s = "Perl"
## Output: "Perl"
#
## Example 3
##
## Input: $s = "Julia"
## Output: "Jaliu"
#
## Example 4
##
## Input: $s = "Uiua"
## Output: "Auiu"
#
############################################################
##
## discussion
##
############################################################
#
# Let's first turn the string into an array of characters. Then
# let's collect the position of all vowels (and whether or not
# they were uppercase). Then we can walk through all vowels and
# write them to their new location in the correct (uppwer/lower)
# case.

def is_upper(char: str) -> bool:
    upper = char.upper()
    if upper == char:
        return True
    return False


def is_vowel(char: str) -> bool:
    vowels = { "a": True, "e": True, "i": True, "o": True, "u": True }
    if char.lower() in vowels:
        return True
    return False

def reverse_vowels(s: str) -> str:
    print(f"Input: {s}")
    chars = list(s)
    vowels = []
    indices = []
    for i in range(len(chars)):
        if is_vowel(chars[i]):
            vowels.append( (i, chars[i] ) )
            indices.append( (i, is_upper(chars[i]) ) )
    indices.reverse()
    for j in range(len(vowels)):
        ( old_index, char ) = vowels[j]
        ( new_index, is_up )  = indices[j]
        new_char = char
        if is_up:
            new_char = char.upper()
        else:
            new_char = char.lower()
        chars[new_index] = new_char
    s = "".join(chars)
    print(f"Output: {s}")
    return s


reverse_vowels("Raku")
reverse_vowels("Perl")
reverse_vowels("Julia")
reverse_vowels("Uiua")

