#!/usr/bin/env python3

import re

def complex_multiply(x, y):
    m1 = re.search(r"(-?\d+)\+?\(?(-?\d+)\)?i", x)
    m2 = re.search(r"(-?\d+)\+?\(?(-?\d+)\)?i", y)
    a, b = int(m1.group(1)), int(m1.group(2))
    c, d = int(m2.group(1)), int(m2.group(2))

    r = a * c - b * d
    i = a * d + b * c

    return f"{r}+({i})i" if i < 0 else f"{r}+{i}i"

examples = [
    {"in": ["1+1i", "1+1i"        ], "out": "0+2i"      },
    {"in": ["1+(-1)i", "1+(-1)i"  ], "out": "0+(-2)i"   },
    {"in": ["0+3i", "0+4i"        ], "out": "-12+0i"    },
    {"in": ["3+4i", "3+(-4)i"     ], "out": "25+0i"     },
    {"in": ["50+(-20)i", "-10+30i"], "out": "100+1700i" },
]

for ex in examples:
    assert complex_multiply(*ex["in"]) == ex["out"]

print("All tests passed!")
