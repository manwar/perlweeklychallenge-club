#!/usr/bin/env python3

import re

def thousand_separator(num):
    num_str = str(num)[::-1]
    num_str = re.sub(r'(\d{3})(?=\d)', r'\1,', num_str)
    return num_str[::-1]

if __name__ == "__main__":
    examples = {
        123:     "123",
        1234:    "1,234",
        1000000: "1,000,000",
        1:       "1",
        12345:   "12,345"
    }

    passed = True
    for input_num, expected in examples.items():
        result = thousand_separator(input_num)
        if result == expected:
            pass
        else:
            passed = False

    if passed:
        print("\nAll tests passed.")
