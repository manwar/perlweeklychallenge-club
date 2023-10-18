#!/usr/bin/env python

from functools import reduce

def concatString(num, arr):
    word = reduce(lambda a, b: a + b, arr)
    words = (
      f'\nUsing @arr{num}, word{num} => "' +
      "' . '".join(arr) +
      f'" => "{word}"'
    )
    return word, words

def sameString(arr1, arr2):
    word1, words1 = concatString(1, arr1)
    word2, words2 = concatString(2, arr2)
    return(word1 == word2, words1 + words2)

def solution(arr1, arr2):
    as_list = '"' + '", "'.join(arr1) + '"'
    print(f'Input: @arr1 = ({as_list})')
    as_list = '"' + '", "'.join(arr1) + '"'
    print(f'       @arr2 = ({as_list})')
    same, words = sameString(arr1, arr2)
    print(f'Output: {same}\n{words}')

print('Example 1:')
solution(["ab", "c"], ["a", "bc"])

print('\nExample 2:')
solution(["ab", "c"], ["ac", "b"])

print('\nExample 3:')
solution(["ab", "cd", "e"], ["abcde"])