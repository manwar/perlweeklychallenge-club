#!/usr/bin/env python

"""
You are given list of integers list of size n and divisor k.

Write a script to find out count of pairs in the given list that satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k
"""

def count_matching_pairs_naive(input, n, k):
    count = 0
    for i, val_i in enumerate(input):
        for val_j in input[i + 1:]:
            if (val_i + val_j ) % k == 0:
                count += 1
    return count

def count_matching_pairs(input, n, k):
    mods = [i % k for i in input]
    count = 0
    for i, mod_i in enumerate(mods):
        for mod_k in mods[i+1:]:
            if mod_i + mod_k == 0 or mod_i + mod_k == k:
                count += 1
    return count

if __name__ == "__main__":
    test_data = [
        [ [ 4, 5, 1, 6 ], 2 , 2 ],
        [ [ 1, 2, 3, 4 ], 2 , 2 ],
        [ [ 1, 3, 4, 5 ], 3 , 2 ],
        [ [ 5, 1, 2, 3 ], 4 , 2 ],
        [ [ 7, 2, 4, 5 ], 4 , 1 ],
    ]

    for input, k, expected in test_data:
        print(f"input: {input}, k:{k}, expected:{expected}")
        val = count_matching_pairs(input, len(input), k)
        assert val == expected, f"{val} == expected {expected}"
        val = count_matching_pairs_naive(input, len(input), k)
        assert val == expected, f"{val} == expected {expected}"
