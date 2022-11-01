#!/usr/bin/env python


def array_degree(input):
    cnt = {}
    loc = {}
    max_len = 0

    for i, c in enumerate(input):
        if c not in cnt:
            cnt[c] = 0
        cnt[c] += 1
        if cnt[c] > max_len:
            max_len = cnt[c]

        # build a mapping of input element to array of indexes where that element is found
        # this could be tightened up by keeping only the first and last element
        if c not in loc:
            loc[c] = []
        loc[c].append(i)

    # severly abused list comprehension that finds the elements with max
    # dimension, and then their first and last location, and sorts by length
    f, l = sorted(
        [
            [l - f, (f, l)]
            for f, l in (
                (loc[k][0], loc[k][-1]) for k, v in cnt.items() if v == max_len
            )
        ]
    )[0][1]
    # and then we take the first one and use it to look up the list from first
    # to last
    return input[f : l + 1]


assert array_degree([1, 3, 3, 2]) == [3, 3]
assert array_degree([1, 2, 1, 3]) == [1, 2, 1]
assert array_degree([1, 3, 2, 1, 2]) == [2, 1, 2]
assert array_degree([1, 1, 2, 3, 2]) == [1, 1]
assert array_degree([2, 1, 2, 1, 1]) == [1, 2, 1, 1]
