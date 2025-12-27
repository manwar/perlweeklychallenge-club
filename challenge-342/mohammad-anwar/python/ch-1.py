#!/usr/bin/env python3

import re

def balance_string(s):
    d = sorted([c for c in s if c.isdigit()])
    l = sorted([c for c in s if c.isalpha()])

    if abs(len(d) - len(l)) > 1:
        return ""

    if len(d) > len(l):
        result = ""
        for i in range(len(d)):
            result += d[i] + (l[i] if i < len(l) else "")
        return result
    elif len(l) > len(d):
        result = ""
        for i in range(len(l)):
            result += l[i] + (d[i] if i < len(d) else "")
        return result
    else:
        if d[0] < l[0]:
            result = ""
            for i in range(len(d)):
                result += d[i] + l[i]
            return result
        else:
            result = ""
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
