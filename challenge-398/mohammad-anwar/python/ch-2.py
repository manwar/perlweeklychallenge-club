#!/usr/bin/env python3

examples = [
    {"in": ["ab","bc","cd","zy"],         "out": "zy"  },
    {"in": ["cba","fed","azy"],           "out": "azy" },
    {"in": ["pop","ada","beb","cfc"],     "out": "pop" },
    {"in": ["aaaa","zzzz","mmmm","aaba"], "out": "aaba"},
    {"in": ["aceg","bdfh","cegi","azbz"], "out": "azbz"},
]

def odd_one_out(*words):
    diff_keys = []
    for word in words:
        c = [ord(ch) for ch in word]
        diffs = [c[i + 1] - c[i] for i in range(len(c) - 1)]
        diff_keys.append(",".join(map(str, diffs)))

    count = {}
    for key in diff_keys:
        count[key] = count.get(key, 0) + 1

    unique_key = next(k for k, v in count.items() if v == 1)
    idx = diff_keys.index(unique_key)

    return words[idx]

for ex in examples:
    assert odd_one_out(*ex["in"]) == ex["out"]

print("All tests passed!")
