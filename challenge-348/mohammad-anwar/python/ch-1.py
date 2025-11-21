#!/usr/bin/env python3

def string_alike(s: str) -> int:
    length = len(s) // 2
    vowels = "aeiouAEIOU"
    v = sum(1 for char in s[:length] if char in vowels)
    return 1 if v > 0 and v == sum(1 for char in s[length:] if char in vowels) else 0

if __name__ == "__main__":
    examples = [
        {"in": "textbook",     "exp": 0},
        {"in": "book",         "exp": 1},
        {"in": "AbCdEfGh",     "exp": 1},
        {"in": "rhythmmyth",   "exp": 0},
        {"in": "UmpireeAudio", "exp": 0},
    ]

    for example in examples:
        result   = string_alike(example["in"])
        expected = example["exp"]
        print(f"Input: {example['in']} -> Got: {result}, Expected: {expected} {'PASS' if result == expected else 'FAIL'}")
