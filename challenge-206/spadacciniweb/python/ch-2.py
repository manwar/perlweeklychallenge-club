# Task 2: Array Pairings
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers having even number of elements..
# Write a script to find the maximum sum of the minimum of each pairs.
# 
# Example 1
# Input: @array = (1,2,3,4)
# Output: 4
# 
# Possible Pairings are as below:
# a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
# b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
# c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
# 
# So the maxium sum is 4.
# 
# Example 2
# Input: @array = (0,2,1,3)
# Output: 2
# 
# Possible Pairings are as below:
# a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
# b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
# c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
# 
# So the maximum sum is 2.
import re
import sys
from functools import reduce

# https://stackoverflow.com/questions/19368375/set-partitions-in-python
def partition(collection):
    if len(collection) == 1:
        yield [ collection ]
        return

    first = collection[0]
    for smaller in partition(collection[1:]):
        # insert `first` in each of the subpartition's subsets
        for n, subset in enumerate(smaller):
            yield smaller[:n] + [[ first ] + subset]  + smaller[n+1:]
        # put `first` in its own subset 
        yield [ [ first ] ] + smaller



if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 2
        or
        len(input) % 2 != 0
        or
        len(list(filter(lambda x: re.search(r'\D', x), input))) != 0):
        sys.exit("Input error\n")

    input = list(map(int, input))
    pairing = []
    for n, p in enumerate(partition(input), 1):
        sets = sorted(p)
        b_pair = True
        for s in sets:
            if len(s) != 2:
                b_pair = False
                break
        if b_pair == True:
            pairing.append(sets)

    l_min = []
    for pairs in list(pairing):
        l_min.append([min(s) for s in pairs])

    print(max([sum(s) for s in l_min]))
