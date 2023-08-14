#!/usr/bin/env python3

def two_out_of_three( *elements ):
    elemCount = {}
    for elem in elements:
        uniq_elements = set(elem)
        for num in uniq_elements:
            elemCount[num] = elemCount.get(num, 0) + 1

    two_out_of_three = []
    for key, value in elemCount.items():
        if value > 1:
            two_out_of_three.append(key)
    return sorted(two_out_of_three)
