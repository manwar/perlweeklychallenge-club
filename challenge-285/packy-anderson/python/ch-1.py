#!/usr/bin/env python

def noConnection(routes):
  starts = set([ x[0] for x in routes ])
  ends   = set([ x[1] for x in routes ])
  noConnection = ends - starts
  if len(noConnection) == 0:
    return 'no terminal destinations'
  if len(noConnection) > 1:
    return 'multiple terminal destinations'
  return list(noConnection)[0]

def tupleJoin(listVar):
  return ', '.join([
     f'[{x[0]}, {x[1]}]' for x in listVar
  ])

def solution(routes):
  print(f'Input: @routes = ({ tupleJoin(routes) })')
  print(f'Output: {noConnection(routes)}')

print('Example 1:')
solution([["B","C"], ["D","B"], ["C","A"]])

print('\nExample 2:')
solution([["A","Z"], ])

print('\nBad Input: multiple terminal destination')
solution([["A","B"], ["C", "D"]])

print('\nBad Input: no terminal destinations')
solution([["A","Z"], ["Z", "A"]])
