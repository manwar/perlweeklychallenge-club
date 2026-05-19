#!/usr/bin/env python3

import re

def count_vowel(s):
    count  = []
    length = len(s)

    for start in range(length):
        for substr_length in range(5, length - start + 1):
            sub = s[start:start + substr_length]
            if not re.match(r'^[aeiou]+$', sub):
                continue
            if not ('a' in sub and 'e' in sub and 'i' in sub and 'o' in sub and 'u' in sub):
                continue
            count.append(sub)

    return count

def test():
    examples = [
        {"in": "aeiou", "out": ["aeiou"]},
        {"in": "aaeeeiioouu", "out": ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"]},
        {"in": "aeiouuaxaeiou", "out": ["aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"]},
        {"in": "uaeiou", "out": ["uaeio", "uaeiou", "aeiou"]},
        {"in": "aeioaeioa", "out": []},
    ]

    for ex in examples:
        result = count_vowel(ex["in"])
        assert result == ex["out"], f"Failed for {ex['in']}: got {result}, expected {ex['out']}"

    print("All tests passed!")

if __name__ == "__main__":
    test()
