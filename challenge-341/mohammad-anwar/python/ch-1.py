#!/usr/bin/env python3

def typable_word_count(text: str, broken_keys: list[str]) -> int:
    words = text.split()
    if not broken_keys:
        return len(words)

    broken_chars  = set(key.lower() for key in broken_keys)
    typable_count = sum(
        1 for word in words
        if all(char.lower() not in broken_chars for char in word)
    )

    return typable_count

examples = [
    ('Hello World',          ['d'],      1),
    ('apple banana cherry',  ['a', 'e'], 0),
    ('Coding is fun',        [],         3),
    ('The Weekly Challenge', ['a', 'b'], 2),
    ('Perl and Python',      ['p'],      1),
]

for text, keys, expected in examples:
    result = typable_word_count(text, keys)
    assert result == expected, (
        f"Assertion Failed: Input: '{text}', Keys: {keys} | "
        f"Expected: {expected}, Got: {result}"
    )

print("\nAll tests passed successfully.")
