#!/usr/bin/env python

knightMoveList = [
  [-2, -1], [-2, +1], [-1, -2], [-1, +2],
  [+2, -1], [+2, +1], [+1, -2], [+1, +2],
]

def knightMoves(coordinates):
  letter = coordinates[0:1]
  num = int(coordinates[1:])
  endpoints = []
  for colRow in knightMoveList:
    col, row = colRow
    newcol = chr(ord(letter) + col)
    if "a" <= newcol <= "h":
      newrow = num + row
      if 1 <= newrow <= 8:
        endpoints.append(newcol + str(newrow))
  return endpoints


def leastMoves(start, end):
  # trivial case: we're already at the end point
  if start == end:
      return ( 0, end )

  # Ok, we're going to need to search for a solution.

  # Keep track of how many moves it takes to get to
  # a particular position, starting at $start
  moves = { start: 0 }

  # also keep track of the path to get there
  path_to = { start: start }

  # make a queue of starting points
  queue = [ start ]

  while ( queue ):
    start = queue.pop(0)

    # figure out the valid moves that we haven't been to yet
    endpoints = [
      m for m in knightMoves(start) if m not in path_to
    ]

    for next in endpoints:
      # build the path to the next endpoint
      path_to[next] = f'{path_to[start]} -> {next}'

      # increment the number of moves it takes to get there
      moves[next] = moves[start] + 1

      # have we arrived at our destination
      if next == end:
        return ( moves[next], path_to[next] )

      # no? then push this space onto our processing queue
      queue.append(next)

  # we can't get there from here!
  # (only possible when the chessboard is an odd size)
  return ( -1, "no path found" )

def solution(start, end):
    print(f'Input: $start = \'{start}\', $end = \'{end}\'')
    count, moves = leastMoves(start, end)
    print(f'Output: {count}\n\n{moves}')

print('Example 1:')
solution('g2', 'a8')

print('\nExample 2:')
solution('g2', 'h2')

print('\nExample 3:')
solution('a1', 'h8')
