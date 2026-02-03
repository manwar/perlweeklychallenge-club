#!/usr/bin/env python3

def caesar_encrypt(str_, shift):
    shift %= 26
    result = ''
    for char in str_:
        if char.islower():
            result += chr( (ord(char) - ord('a') + shift) % 26 + ord('a') )
        else:
            result += char
    return result

# Test cases
tests = [
    ("abc", 1, "bcd"),
    ("xyz", 2, "zab"),
    ("abc", 27, "bcd"),
    ("hello", 5, "mjqqt"),
    ("perl", 26, "perl"),
]

print("Running tests:")
all_pass = True
for i, (str_, shift, expected) in enumerate(tests, 1):
    got = caesar_encrypt(str_, shift)
    status = "PASS" if got == expected else "FAIL"
    all_pass &= (got == expected)
    print(f"Example {i}: {status} (got '{got}', expected '{expected}')")

print("\nAll tests passed!") if all_pass else None
