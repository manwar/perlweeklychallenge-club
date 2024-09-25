#!/usr/bin/env python

# helper functions to determine if the adjacent cells
# BEFORE this one have the same value
def prevXSame(matrix, x, y):
  return x > 0 and matrix[y][x] == matrix[y][x-1]

def prevYSame(matrix, x, y):
  return y > 0 and matrix[y][x] == matrix[y-1][x]

def contiguousBlock(matrix):
  # first, find out the size of the matrix
  height = len(matrix)
  width  = len(matrix[0])
  # start a counter for the number of blocks
  next_block = 0
  # a matrix of blocks
  blocks = [[None for x in range(width)] for y in range(height)]

  for y in range(height):
    for x in range(width):
      if prevXSame(matrix, x, y):
        # make this cell's block number match
        # the one above it
        blocks[y][x] = blocks[y][x-1]

      if prevYSame(matrix, x, y):
        # if we've already assigned a block number
        # based on the prev X being the same, and
        # it's a DIFFERENT block than the prev Y
        if (blocks[y][x] is not None and
            blocks[y][x] != blocks[y-1][x]):
          # renumber the block for the prev X to
          # match the block for the prev Y
          new = blocks[y-1][x]
          old = blocks[y][x-1]
          for y2 in range(y+1):
            for x2 in range(width):
              if blocks[y2][x2] == old:
                blocks[y2][x2] = new

        # make this cell's block number match
        # the one before it
        blocks[y][x] = blocks[y-1][x]

      if blocks[y][x] is None:
        # neither previous adjacent cell matches,
        # assign a new block number to this cell
        blocks[y][x] = next_block
        next_block += 1

  # now let's count the elements in each block
  counts = [0 for x in range(next_block)]
  for y in range(height):
    for x in range(width):
      counts[blocks[y][x]] += 1

  return max(counts)

def formatMatrix(matrix, indent=17):
  output = []
  for row in matrix:
    output_row = ' ' * indent + '  ['
    output_row += ', '.join(map(lambda i: f"'{i}'", row))
    output_row += ']'
    output.append(output_row)

  return(
    "[\n" + ",\n".join(output) + "\n" +
    ' ' * indent + ']'
  )

def solution(matrix):
    print(f'Input: $matrix = {formatMatrix(matrix)}')
    print(f'Output: { contiguousBlock(matrix) }')

print('Example 1:')
solution([
           ['x', 'x', 'x', 'x', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'x', 'x', 'o', 'o'],
         ])

print('\nExample 2:')
solution([
           ['x', 'x', 'x', 'x', 'x'],
           ['x', 'o', 'o', 'o', 'o'],
           ['x', 'x', 'x', 'x', 'o'],
           ['x', 'o', 'o', 'o', 'o'],
         ])

print('\nExample 3:')
solution([
           ['x', 'x', 'x', 'o', 'o'],
           ['o', 'o', 'o', 'x', 'x'],
           ['o', 'x', 'x', 'o', 'o'],
           ['o', 'o', 'o', 'x', 'x'],
         ])
