#!/usr/bin/env python3

import re

def balance_string(s):
    # Extract all digits and sort them
    d = sorted([c for c in s if c.isdigit()])
    # Extract all letters and sort them
    l = sorted([c for c in s if c.isalpha()])

    # Return empty string if impossible
    if abs(len(d) - len(l)) > 1:
        return ""

    # If more digits than letters:
    if len(d) > len(l):
        # Join all elements into a string
        result = ""
        # For each index: digit + letter (or empty if no letter)
        for i in range(len(d)):
            result += d[i] + (l[i] if i < len(l) else "")
        return result
    # Else if more letters than digits:
    elif len(l) > len(d):
        # Join all elements into a string
        result = ""
        # For each index: letter + digit (or empty if no digit)
        for i in range(len(l)):
            result += l[i] + (d[i] if i < len(d) else "")
        return result
    # Else (equal counts):
    else:
        # If first digit < first letter lexicographically:
        if d[0] < l[0]:
            # Join all elements into a string
            result = ""
            # For each index: digit + letter
            for i in range(len(d)):
                result += d[i] + l[i]
            return result
        # Else:
        else:
            # Join all elements into a string
            result = ""
            # For each index: letter + digit
            for i in range(len(d)):
                result += l[i] + d[i]
            return result

examples = [
    ["a0b1c2",  "0a1b2c" ],
    ["abc12",   "a1b2c"  ],
    ["0a2b1c3", "0a1b2c3"],
    ["1a23",    ""       ],
    ["ab123",   "1a2b3"  ],
]

for example in examples:
    input_str, expected = example
    result = balance_string(input_str)
    print(f"Pass: {result == expected}")
