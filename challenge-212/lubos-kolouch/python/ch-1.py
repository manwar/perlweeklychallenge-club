#!/usr/bin/env python
# -*- coding: utf-8 -*-


def jump_forward(word, jumps):
    result = []

    for i, letter in enumerate(word):
        is_upper = letter.isupper()
        base = 65 if is_upper else 97  # Base ASCII code for upper or lower case
        current = ord(letter) - base  # Convert to 0-based index
        new_index = (current + jumps[i]) % 26  # Apply jump and mod 26
        result.append(chr(new_index + base))  # Convert back to ASCII character

    return "".join(result)


def test_jump_forward():
    assert jump_forward("Perl", [2, 22, 19, 9]) == "Raku", "Test case 1"
    assert jump_forward("Raku", [24, 4, 7, 17]) == "Perl", "Test case 2"
    print("All tests passed!")


if __name__ == "__main__":
    test_jump_forward()
