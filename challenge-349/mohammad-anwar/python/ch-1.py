#!/usr/bin/env python3

def power_string(s: str) -> int:
    if len(s) == 0:
        return 0

    max_len = 1
    count   = 1

    for i in range(1, len(s)):
        if s[i] == s[i-1]:
            count += 1
        else:
            if count > max_len:
                max_len = count
            count = 1

    if count > max_len:
        max_len = count

    return max_len


examples = [
    {'in': "textbook"            , 'exp': 2},
    {'in': "aaaaa"               , 'exp': 5},
    {'in': "hoorayyy"            , 'exp': 3},
    {'in': "x"                   , 'exp': 1},
    {'in': "aabcccddeeffffghijjk", 'exp': 4},
]

for idx, ex in enumerate(examples, 1):
    result = power_string(ex['in'])
    assert result == ex['exp']

print("All tests passed.")
