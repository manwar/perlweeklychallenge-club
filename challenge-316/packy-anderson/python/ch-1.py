#!/usr/bin/env python

def circular(arr):
  while (len(arr) > 1):
    # get the last letter of the first element 
    last  = ( arr[0] )[-1]
    # and the first letter of the second element
    first = ( arr[1] )[0]
    # if they don't match case-insensitively, return false
    if last.lower() != first.lower():
       return False
    # remove the first element from the list
    arr.pop(0)
  return True; # we got through all the elements

def comma_join(arr):
    return ', '.join(map(lambda i: f'"{i}"', arr))

def solution(arr):
    print(f'Input: @arr = ({comma_join(arr)})')
    print(f'Output: {circular(arr)}')

print('Example 1:')
solution(["perl", "loves", "scala"])

print('\nExample 2:')
solution(["love", "the", "programming"])

print('\nExample 3:')
solution(["java", "awk", "kotlin", "node.js"])
