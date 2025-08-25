#!/usr/bin/env python

def emptyGameBoard():
  return [
    [ '_', '_', '_' ],
    [ '_', '_', '_' ],
    [ '_', '_', '_' ]
  ]

def displayGameBoard(board):
  output = "Game Board:\n"
  for r in board:
    output += "[ " + " ".join(r) + " ]\n"
  return output

def makeMove(letter, move, board):
  y,x = move[0], move[1]
  board[y][x] = letter

def find_winner(moves):
  board = emptyGameBoard()

  letter = 'A'
  movecount = len(moves)
  while moves:
    move = moves.pop(0)
    makeMove(letter, move, board)
    letter = 'B' if letter == 'A' else 'A'

  # check rows
  for y in range(3):
    if (board[y][0] != '_' and
        (board[y][0] == board[y][1] == board[y][2])):
      return board[y][0], displayGameBoard(board)

  # check columns
  for x in range(3):
    if (board[0][x] != '_' and
        (board[0][x] == board[1][x] == board[2][x])):
      return board[0][x], displayGameBoard(board)

  # check diagonals
  if (board[1][1] != '_' and 
      ((board[0][0] == board[1][1] == board[2][2]) or
       (board[2][0] == board[1][1] == board[0][2]))):
    return board[1][1], displayGameBoard(board)

  # no winner
  return (
    'Pending' if movecount < 9 else 'Draw',
    displayGameBoard(board)
  )

def solution(moves):
  move_list = ', '.join(
    [ '[' + ','.join([str(c) for c in r]) + ']' for r in moves ]
  )
  print(f'Input: @moves = ({move_list})')
  winner, board = find_winner(moves)
  print(f'Output: {winner}\n\n{board}')


print('Example 1:')
solution([[0,0],[2,0],[1,1],[2,1],[2,2]])

print('\nExample 2:')
solution([[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]])

print('\nExample 3:')
solution([[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]])

print('\nExample 4:')
solution([[0,0],[1,1]])

print('\nExample 5:')
solution([[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]])
