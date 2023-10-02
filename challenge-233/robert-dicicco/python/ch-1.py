#!/usr/bin/env python
'''
AUTHOR: Robert DiCicco
DATE  : 2023-09-09
Challenge 233 Task one Similar Words ( Python )
'''
from itertools import combinations

#words = ["aba", "aabb", "abcd", "bac", "aabc"]
words = ["aabb", "ab", "ba"]

pair = 0
cnt = 1

def unique(list1):
    unique_list = []
    for x in list1:
        if x not in unique_list:
            unique_list.append(x)
    return unique_list

print(f"Input: @words = {words}")
for wds in (list(combinations(words, 2))):
    arr = [x for x in sorted(wds[0])]
    str1 = "".join(unique(arr))

    arr = [x for x in sorted(wds[1])]
    str2 = "".join(unique(arr))

    if str1 == str2:
       print(f"\tpair{cnt} [{wds[0]} {wds[1]}]")
       cnt += 1
       pair += 1

print(f"Output: {pair}")

'''
SAMPLE OUTPUT
python .\SimilarWords.py

Input: @words = ['aba', 'aabb', 'abcd', 'bac', 'aabc']
        pair1 [aba aabb]
        pair2 [bac aabc]
Output: 2

python .\SimilarWords.py
Input: @words = ['aabb', 'ab', 'ba']
        pair1 [aabb ab]
        pair2 [aabb ba]
        pair3 [ab ba]
Output: 3
'''
