#!/usr/bin/env python3

# Challenge 162
#
# Task 2: Wheatstone-Playfair
# Submitted by: Roger Bell_West
# Implement encryption and decryption using the Wheatstone-Playfair cipher.
#
# Examples:
# (These combine I and J, and use X as padding.)
#
# encrypt("playfair example", "hide the gold in the tree stump")
# = "bmodzbxdnabekudmuixmmouvif"
#
# decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"

class WPcipher:
    def __init__(self, key_phrase):
        self.key = [[] for _ in range(5)]
        self.letters = {}
        self.make_key(key_phrase)

    def make_key(self, key_phrase):
        row, col = 0, 0
        for c in (key_phrase.lower() + ''.join(chr(i) for i in range(ord('a'), ord('z') + 1))):
            if not c.isalpha() or c not in 'abcdefghijklmnopqrstuvwxyz':
                continue
            c = 'i' if c == 'j' else c
            if c in self.letters:
                continue

            self.key[row].append(c)
            self.letters[c] = (row, col)

            col += 1
            if col >= 5:
                row += 1
                col = 0
                if row >= 5:
                    break

    def peek(self, row, col):
        return self.key[(row + 5) % 5][(col + 5) % 5]

    def encrypt_pair(self, a, b, direction):
        for char in (a, b):
            if char not in 'abcdefghiklmnopqrstuvwxyz':
                raise ValueError(f"Invalid character: {char}")
        if a == b:
            raise ValueError("Characters must not be the same")

        row1, col1 = self.letters[a]
        row2, col2 = self.letters[b]

        if row1 == row2:
            return (self.peek(row1, col1 + direction),
                    self.peek(row2, col2 + direction))
        elif col1 == col2:
            return (self.peek(row1 + direction, col1),
                    self.peek(row2 + direction, col2))
        else:
            return (self.peek(row1, col2),
                    self.peek(row2, col1))

    def encrypt_string(self, text, direction):
        text = text.lower()
        out = ""
        while text:
            if len(text) == 1:
                text += "x"
            if text[0] == text[1:2]:  # repeated first character
                a = text[0]
                b = "x"
                text = text[1:]
            else:
                a = text[0]
                b = text[1]
                text = text[2:]

            x, y = self.encrypt_pair(a, b, direction)
            out += x + y
        return out

    def encrypt(self, text):
        text = ''.join(filter(str.isalpha, text)).lower().replace('j', 'i')
        return self.encrypt_string(text, 1)

    def decrypt(self, code):
        return self.encrypt_string(code, -1)


import sys

if len(sys.argv) != 4:
    raise ValueError("Usage: ch-2.py -e|-d key text")

op, key_phrase, text = sys.argv[1], sys.argv[2], sys.argv[3]

wp = WPcipher(key_phrase)
if op == "-e":
    print(wp.encrypt(text))
elif op == "-d":
    print(wp.decrypt(text))
else:
    raise ValueError("Usage: ch-2.py -e|-d key text")
