#!/usr/bin/env python3

def peak_point(nums):
    n = nums
    return ", ".join(str(i) for i in range(len(n)) if
        (i == 0 and len(n) > 1 and n[0] > n[1]) or
        (i == len(n) - 1 and len(n) > 1 and n[-1] > n[-2]) or
        (0 < i < len(n) - 1 and n[i] > n[i-1] and n[i] > n[i+1]))

def test_examples():
    examples = [
        {"in": [1, 3, 2],             "exp": "1"},
        {"in": [2, 4, 6, 5, 3],       "exp": "2"},
        {"in": [1, 2, 3, 2, 4, 1],    "exp": "2, 4"},
        {"in": [5, 3, 1],             "exp": "0"},
        {"in": [1, 5, 1, 5, 1, 5, 1], "exp": "1, 3, 5"},
    ]

    for example in examples:
        result = peak_point(example["in"])
        expected = example["exp"]
        assert result == expected, f"Failed for {example['in']}: expected '{expected}', got '{result}'"
        print(f"{example['in']} -> {result}")

if __name__ == "__main__":
    test_examples()
    print("All tests passed!")
