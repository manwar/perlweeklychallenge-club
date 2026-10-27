#!/usr/bin/env python3

examples = [
    {"in": [3,6,12],      "out": [3,6,12]     },
    {"in": [1,2,4,8],     "out": [1,2,4,8]    },
    {"in": [7,8,9,10],    "out": [8,10,7,9]   },
    {"in": [5,9,15,17],   "out": [5,9,15,17]  },
    {"in": [11,13,14,19], "out": [14,13,11,19]},
]

def sort_binary_reflection(arr):
    def ref(x):
        return int(bin(x)[2:][::-1], 2)

    return sorted(arr, key=lambda x: (ref(x), x))

for ex in examples:
    assert sort_binary_reflection(ex["in"]) == ex["out"], f"Failed for {ex['in']}"

print("All tests passed successfully!")
