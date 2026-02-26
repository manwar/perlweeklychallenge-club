#!/usr/bin/env python3

def justify_text(s: str, width: int) -> str:
    pad   = width - len(s)
    left  = pad // 2
    right = pad - left
    return "*" * left + s + "*" * right

examples = [
    (["Hi",    5], "*Hi**"),
    (["Code", 10], "***Code***"),
    (["Hello", 9], "**Hello**"),
    (["Perl",  4], "Perl"),
    (["A",     7], "***A***"),
    (["",      5], "*****"),
]

i = 1
for (s, width), expected in examples:
    result = justify_text(s, width)
    if result == expected:
        print("ok =", i)
    i = i + 1
