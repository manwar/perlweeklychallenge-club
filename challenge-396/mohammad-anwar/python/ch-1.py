#!/usr/bin/env python3

def finishing_order(order, friends):
    f = set(friends)
    return [x for x in order if x in f]

examples = [
    { "in": [[3, 1, 4, 2, 5], [1, 2, 4]],    "out": [1, 4, 2]    },
    { "in": [[5, 4, 3, 2, 1], [1, 3, 5]],    "out": [5, 3, 1]    },
    { "in": [[2, 4, 1, 3], [1, 2, 3, 4]],    "out": [2, 4, 1, 3] },
    { "in": [[4, 1, 3, 2], [3]],             "out": [3]          },
    { "in": [[1, 3, 2, 6, 5, 4], [1, 2, 3]], "out": [1, 3, 2]    },
]

for ex in examples:
    assert finishing_order(*ex["in"]) == ex["out"]

print("All tests passed!")
