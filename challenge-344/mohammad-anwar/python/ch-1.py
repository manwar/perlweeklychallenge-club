#!/usr/bin/env python3

def add_to_array_form(arr, x):
    return [int(d) for d in str(int(''.join(map(str, arr))) + x)]

if __name__ == "__main__":
    examples = [
        {"input": {"arr": [1, 2, 3, 4],    "x": 12},   "exp": [1, 2, 4, 6]},
        {"input": {"arr": [2, 7, 4],       "x": 181},  "exp": [4, 5, 5]},
        {"input": {"arr": [9, 9, 9],       "x": 1},    "exp": [1, 0, 0, 0]},
        {"input": {"arr": [1, 0, 0, 0, 0], "x": 9999}, "exp": [1, 9, 9, 9, 9]},
        {"input": {"arr": [0],             "x": 1000}, "exp": [1, 0, 0, 0]},
    ]

    for example in examples:
        result = add_to_array_form(example["input"]["arr"], example["input"]["x"])
        assert result == example["exp"], f"Expected {example['exp']}, got {result}"

    print("All tests passed!")
