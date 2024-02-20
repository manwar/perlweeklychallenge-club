#!/usr/bin/env python

def maximumPairs(words):
    count = 0
    while words:
        # the the first word off the list
        first = words.pop(0)
        # now compare to the rest of the words in the list
        for i in range(len(words)):
            second = words[i]
            if first == second[::-1]:
                # we found a pair
                count += 1
                # remove words[i] from the list
                words.pop(i)
                # we don't need to compare
                # any more words to first
                break
    return count

def comma_join(arr):
    return '", "'.join(arr)

def solution(words):
    print(f'Input: @words = ({words})')
    count = maximumPairs(words)
    print(f'Output: {count}')

print('Example 1:')
solution(["ab", "de", "ed", "bc"])

print('\nExample 2:')
solution(["aa", "ba", "cd", "ed"])

print('\nExample 3:')
solution(["uv", "qp", "st", "vu", "mn", "pq"])
