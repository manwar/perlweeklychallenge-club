#!/usr/bin/env python3
# Python 3.9.2 on Debian GNU/Linux 11 (bullseye)

print('challenge-212-task1')

# Task 1: Jumping Letters
# You are given a word having alphabetic characters only, and a list of positive integers of the same length
# Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list.
# The given list would have exactly the number as the total alphabets in the given word.

def jumping_letters(word: str, jump: list[int]) -> None:
    lower = [ c.islower() for c in word ]
    ascii = [ ord(c.upper()) for c in word ]
    ascii_ord = [ (o + jump[i]) if (o + jump[i]) < ord('Z') else ((o + jump[i]) + ord('A') - 1 ) % (ord('Z')) for i, o in enumerate(ascii) ]
    res = ''.join([ str(chr(c)).lower() if lower[i] else str(chr(c)) for i, c in enumerate(ascii_ord)])
    print(f"{word}, '{jump}': {res}")

def main():
    word, jump = 'Perl', [2, 22, 19, 9]
    jumping_letters(word, jump)
    word, jump = 'Raku', [24, 4, 7, 17]
    jumping_letters(word, jump)

if __name__ == '__main__':
    main()
