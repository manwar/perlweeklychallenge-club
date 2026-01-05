#!/usr/bin/env python3
# See: Task 2 in https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
# Task 2 - Mountain Array

def sign(val):
    return (0 if val == 0 else (1 if val > 0 else -1))
       
def find_gt(val, seq):
    pos = -1
    for entry in seq:
        pos += 1
        if entry > val:
            break
    else:
        pos = -1

    return pos


def find_lt(val, seq):
    pos = -1
    for entry in seq:
        pos += 1
        if entry < val:
            break
    else:
        pos = -1

    return pos

def challenge(l1):

    l2 = [ sign(v[0] - v[1]) for v in zip(l1[0:], l1[1:]) ]

    # Check if begin of sequence is increasing
    if len(l2) < 2 or l2[0] != -1:
        return False

    # Find value greater than -1 (0 or 1)
    i_1 = find_gt(-1, l2)
    if i_1 == -1:
        return False

    # Find value less then 1 (0 or -1)
    i_2 = find_lt(1, l2[i_1:])
    if i_2 == -1:
        # Not exists - all values in sequence after max are decrasing
        return True

    return False 

def test(array):
    print(f'Array: {array} \nResult: {challenge(array)}')
    print()

if __name__ == "__main__":

    test([1, 2, 3, 4, 5])

    test([0, 2, 4, 6, 4, 2, 0])

    test([5, 4, 3, 2, 1])
    
    test([1, 3, 5, 5, 4, 2])
    
    test([1, 3, 2])

