#!/usr/bin/env python

import re

is_vowel = re.compile('[aeiou]', re.IGNORECASE)

def reverseVowels(s):
    # split string into letters
    letters = list(s)

    # find the vowels
    vowels = [ v for v in letters if is_vowel.match(v) ]

    # replace each vowel in reverse order, converting
    # any uppercase letters to lowercase
    for i in range(len(s)):
        if is_vowel.match(letters[i]):
            letters[i] = vowels.pop(-1)

    # rejoin the array as a string, title casing it
    return ''.join(letters).title()

def solution(s):
    print(f'Input: $s = "{s}"')
    print(f'Output: "{reverseVowels(s)}"')

print('Example 1:')
solution("Raku")

print('\nExample 2:')
solution("Perl")

print('\nExample 3:')
solution("Julia")

print('\nExample 4:')
solution("Uiua")