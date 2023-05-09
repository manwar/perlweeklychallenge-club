#!/usr/bin/env python3
# Python 3.9.2 on Debian GNU/Linux 11 (bullseye)

print('challenge-216-task1')

# Task 1: Registration Number
# You are given a list of words and a random registration number.
# Write a script to find all the words in the given list that has every letter in the given registration number.

# Example 1
# Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
# Output: ('abcd')

# Example 2
# Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
# Output: ('job', 'bjorg')

# Example 3
# Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
# Output: ('crack', 'rac')

def registration_number(reg: str, words: list[str]) -> list[str]:
    out = []
    print(f"Input: words = ({words}), reg = '{reg}'")
    r = set( [ i for i in reg.lower() if i.isalpha() ])
    for word in words:
        w = set(word.lower())
        if r.issubset(w): out.append(word)
    return out


def main():    
    print("Output: ", registration_number('AB1 2CD', ['abc', 'abcd', 'bcd']),    "\n")
    print("Output: ", registration_number('007 JB',  ['job', 'james', 'bjorg']), "\n")
    print("Output: ", registration_number('C7 RA2',  ['crack', 'road', 'rac']),  "\n")


if __name__ == '__main__':
    main()
